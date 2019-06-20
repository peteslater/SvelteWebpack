<script>
  import Button from './Button.svelte';
  export let message;
</script>

<style>
  h1 {
    font-family: sans-serif;
  }

  div {
    text-align: center;
  }

  h1 {
    color: purple;
  }
</style>

<div>
  <h1>{message}</h1>

  <Button id='first'></Button>
</div>
