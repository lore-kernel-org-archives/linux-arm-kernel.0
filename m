From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 10:23:53 +0200
Subject: [PATCH 1/2] drivers: create a pin control subsystem v9
In-Reply-To: <20111009093651.GC24198@S2100-06.ap.freescale.net>
References: <1317629862-13549-1-git-send-email-linus.walleij@stericsson.com>
	<20111009093651.GC24198@S2100-06.ap.freescale.net>
Message-ID: <CACRpkdbdz0FE57TdVryKD+X2=1sf-M9NgiZzm+Sm+WYhU6n_bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 9, 2011 at 11:36 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

>> + * @hog_on_boot: if this is set to true, the regulator subsystem will itself
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?^^^^^^^^^
> s/regulator/pinmux?

Yep!

>> +#endif /* !CONFIG_PINCTRL */
>
> s/!CONFIG_PINCTRL/CONFIG_PINMUX?

Yep!

Foldes into original patch with a fixup comment.

Can I have your Reviewed-by: tag on this subsystem?

Yours,
Linus Walleij
