$(document).ready(function(){
    $('[data-countdown]').each(function() {
        var $this = $(this), finalDate = $(this).data('countdown');
        $this.countdown(finalDate, function(event) {
            var format = '%H:%M:%S';
            if(event.offset.days > 0) {
                format = '%-D day%!D ' + format;
            }
            $this.html(event.strftime(format));
        });
    });
});
