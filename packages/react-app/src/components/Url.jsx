import React from "react";
import { useInput } from '../hooks';

export function NameForm(props) {
  const { value, bind, reset } = useInput('');
  
  const handleSubmit = (evt) => {
      evt.preventDefault();
      alert(`Submitting Name ${value}`);
      reset();
  }
  return (
    <form onSubmit={handleSubmit}>
      <label>
        Name:
        <input type="text" {...bind} />
      </label>
      <input type="submit" value="Submit" />
    </form>
  );
}