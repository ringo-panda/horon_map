document.addEventListener("turbolinks:load", function () {
  $(function () {

    function addHoron(horon) {
      let html = `<button type="button" class="list-group-item list-group-item-action recommend-horon" value="${horon.name}">${horon.name}</button>`;
      $("#horon_search--result").append(html);
    };


    $("#keyword-input").on("keyup", function () {
      let input = $("#keyword-input").val();
      $.ajax({
        type: 'GET',
        url: '/search',
        data: {
          keyword: input
        },
        dataType: 'json'
      }).done(function (horons) {
        $("#horon_search--result").empty();

        if (horons.length !== 0) {
          horons.forEach(function (horon) {
            addHoron(horon);
          });
        } else if (input.length == 0) {
          return false;
        }
      })
    });

    $(document).on('click', '.recommend-horon', function () {
      let horon = $(this).val();
      console.log(horon);
      $("#keyword-input").val(horon);
    });
  });
});
