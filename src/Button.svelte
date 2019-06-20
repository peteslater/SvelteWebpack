<style>
  .button {
    display: inline-block;
    width: 300px;
    height: 300px;
    border-radius: 10%;
    overflow: hidden;
    background-image: url('image.jpg');
    filter: grayscale(25%);
    cursor: pointer;
  }

  .button-overlay {
    width: 30%;
    height: 30%;
    border-radius: 50%;
    background-color: white;
    position: relative;
    top: 35%;
    left: 35%;
    transition: transform 0.3s;
    transition-timing-function: ease-in-out;
    filter: opacity(50%);
  }

  .button-overlay-img {
    width: 20%;
    height: 20%;
    position: absolute;
    top: 40%;
    left: 40%;
    transition-delay: 0.1s;
  }

  .button:hover .button-overlay {
    transform: scale(7);
  }

  .button:hover .button-overlay-img {
    filter: invert(100%);
  }
</style>

<script>
  export let id;

  function logClick() {
    console.log(`CLICKED ${id}`);
  }
</script>

<div class="button" on:click="{logClick}">
  <div class="button-overlay"/>
  <img class="button-overlay-img" src="camera.svg" alt=""/>
</div>
