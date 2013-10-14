From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 14 Oct 2013 13:28:37 +0800
Subject: [PATCH 4/4] sound/soc/atmel: don't use
 devm_pinctrl_get_select_default() in probe
In-Reply-To: <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
 <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
Message-ID: <525B8105.6090303@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram Sang,

On 10/14/2013 00:17, Wolfram Sang wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for setting the default pins.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>   sound/soc/atmel/atmel_wm8904.c | 8 --------
>   1 file changed, 8 deletions(-)

Tested OK on at91sam9n12ek and sama5d3xek board.
Thanks.

Acked-by: Bo Shen <voice.shen@atmel.com>

Best Regards,
Bo Shen
