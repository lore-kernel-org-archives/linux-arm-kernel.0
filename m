From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 20 Sep 2016 09:30:08 +0200
Subject: [PATCH] ARM: uniphier: select ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <1474346599-29925-1-git-send-email-yamada.masahiro@socionext.com>
References: <1474346599-29925-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1474356608.4030.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

Am Dienstag, den 20.09.2016, 13:43 +0900 schrieb Masahiro Yamada:
> The UniPhier reset driver (drivers/reset/reset-uniphier.c) has been
> merged.  Select ARCH_HAS_RESET_CONTROLLER from the SoC Kconfig.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Philipp,
> 
> IIRC, you mentioned that you were planning to consolidate the double
> gurad by CONFIG_RESET_CONTROLLER and CONFIG_ARCH_HAS_RESET_CONTROLLER.
> 
> I have not seen it in the ML, so I am sending this.
> 
> Please let me know if you have some updates.

I had started to doodle a bit, see

    git fetch git://git.pengutronix.de/git/pza/linux.git refs/heads/reset/kconfig

but I haven't found time for cleanup and testing.

regards
Philipp
