From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 18:26:43 +0100
Subject: [PATCH] pinctrl: at91-pio4: fix memleak after using dt map
In-Reply-To: <1448979542-1202-1-git-send-email-ludovic.desroches@atmel.com>
References: <1448979542-1202-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkda7S+TgoZU0ApuVvYtOty-vaBLzPLeEkbDgw+jPs1_RVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 1, 2015 at 3:19 PM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> configs is allocated by pinconf_generic_parse_dt_config(),
> pinctrl_utils_add_map_configs() duplicates configs so it can and has to
> be freed to prevent memory leaks.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Reported-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Patch applied.

Yours,
Linus Walleij
