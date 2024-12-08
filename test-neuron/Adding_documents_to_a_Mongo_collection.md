---
tags:
  - mongo-db
  - node-js
  - mongoose
  - databases
---

# Adding documents to a collection

We have our database (`playground`) and collection (`courses`) established. We
now need to add documents to our collection. We will do this via a function
since this will be an asynchronous process:

```js
const pythonCourse = new Course({
  name: "Python Course",
  author: "Terry Ogleton",
  tags: ["python", "backend"],
  isPublished: true,
});

async function addCourseDocToDb(courseDocument) {
  try {
    const result = await courseDocument.save();
    console.log(result);
  } catch (err) {
    console.error(err.message);
  }
}

addCourseDocToDb(nodeCourse);
```

When we run this, we call the `save` method on the Mongoose schema. We will then
have the Mongo document outputted to the console:

```
{
  name: 'Python Course',
  author: 'Terry Ogleton',
  tags: [ 'python' ],
  isPublished: true,
  _id: new ObjectId("62f4ac989d2fec2f01596b9b"),
  date: 2022-08-11T07:15:36.978Z,
  __v: 0
}
```

This will also be reflected in Compass:

![](static/mongo-doc-added.png)
