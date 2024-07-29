/**
 * @param { Promise } promise
 * @param { Object= } errorExt - Additional Information you can pass to the err object
 * @return { Promise }
 */
export function to<T, U extends Error = Error>(
  promise: Promise<T>,
  errorExt?: object
): Promise<[U, undefined] | [null, T]> {
  return promise
    .then<[null, T]>((data: T) => [null, data])
    .catch<[U, undefined]>((err: U) => {
      if (errorExt) {
        const parsedError = new Object() as U;

        for (let key of Reflect.ownKeys(err) as string[]) {
          Reflect.set(parsedError, key, Reflect.get(err, key))
        }

        for (let key of Reflect.ownKeys(errorExt) as string[]) {
          Reflect.set(parsedError, key, Reflect.get(errorExt, key))
        }

        return [parsedError, undefined];
      }

      return [err, undefined];
    });
}

export default to;
