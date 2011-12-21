From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 21 Dec 2011 22:56:50 +0200
Subject: [PATCH v2 5/7] MTD: NAND: ams-delta: use GPIO instead of custom
 I/O
In-Reply-To: <ebab42f6ddd313afb38b71880ac7865e4e0ceab4.1324331816.git.jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <ebab42f6ddd313afb38b71880ac7865e4e0ceab4.1324331816.git.jkrzyszt@tis.icnet.pl>
Message-ID: <1324501012.2110.2.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-20 at 00:08 +0100, Janusz Krzysztofik wrote:
> Don't use Amstrad Delta custom I/O functions for controlling the device,
> use GPIO API instead.
> 
> While being at it, add missing gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB).
> 
> Depends on patch 2/7 "ARM: OMAP1: ams-delta: convert latches to
> basic_mmio_gpio"
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Tony Lindgren <tony@atomide.com>

Looks good, thanks!

Reviewed-by: Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>
