# await-to-arkts

> 基于 [await-to-js] 原库3.0.0版本进行适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。
> Async await wrapper for easy error handling

## Install

```sh
ohpm i await-to-js --save
```

## Usage

```extendtypescript
import to from 'await-to-js';

async function asyncTaskWithCb(cb) {
  let err, user, savedTask, notification;

  [err, user] = await to(UserModel.findById(1));
  if (!user) return cb('No user found');

  [err, savedTask] = await to(TaskModel({ userId: user.id, name: 'Demo Task' }));
  if (err) return cb('Error occurred while saving task');

  if (user.notificationsEnabled) {
    [err] = await to(NotificationService.sendNotification(user.id, 'Task Created'));
    if (err) return cb('Error while sending notification');
  }

  if (savedTask.assignedUser.id !== user.id) {
    [err, notification] =
      await to(NotificationService.sendNotification(savedTask.assignedUser.id, 'Task was created for you'));
    if (err) return cb('Error while sending notification');
  }

  cb(null, savedTask);
}

async function asyncFunctionWithThrow() {
  const [err, user] = await to(UserModel.findById(1));
  if (!user) throw new Error('User not found');

}
```

## ArkTs usage

```extendtypescript
interface ServerResponse {
test: number;
}

const p = Promise.resolve({ test: 123 });

const [err, data] = await to<ServerResponse>(p);
console.log(data.test);
```

## License

MIT © [郭佳兵](https://github.com/guojiabing)

[await-to-js]: https://npmjs.org/package/await-to-js

