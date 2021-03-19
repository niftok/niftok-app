import React from "react";
import { useInput } from "../hooks";

export function URLForm(props) {
  const { value, bind, reset } = useInput('');
  
  const handleSubmit = (evt) => {
      evt.preventDefault();
      alert(`Submitting URL ${value}`);
      reset();
  }
  return (
    <form onSubmit={handleSubmit}>
      <label>
        Tik-Tok:
        <input type="url" {...bind} />
      </label>
      <input type="submit" value="Submit" />
    </form>
  );
}