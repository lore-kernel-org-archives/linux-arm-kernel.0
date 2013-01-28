From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jan 2013 15:00:59 -0800
Subject: [PATCH 5/5] ARM: ux500: select the DB8540 pin controller
In-Reply-To: <1359381151-28127-1-git-send-email-linus.walleij@stericsson.com>
References: <1359381151-28127-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130128230059.GE7789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 02:52:31PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The pin controller is an inherent part of the SoC, without
> it the system will not boot, thus it needs to be selected
> from Kconfig.
> 
> Cc: arm at kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Requesting ACK from ARM SoC on this patch.

Acked-by: Olof Johansson <olof@lixom.net>

... but I wonder if this is growing out of hand. Since they will always
be selected (and required) for UX500_SOC_DB8500, why not just make them
silent options that default to y with that as a depend?


-Olof
