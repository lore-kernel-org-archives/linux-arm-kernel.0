From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 21 Dec 2011 20:45:34 +0100
Subject: [PATCH v2 5/7] MTD: NAND: ams-delta: use GPIO instead of custom
 I/O
In-Reply-To: <20111221191211.GE24444@atomide.com>
References: <cover.1324331816.git.jkrzyszt@tis.icnet.pl>
 <ebab42f6ddd313afb38b71880ac7865e4e0ceab4.1324331816.git.jkrzyszt@tis.icnet.pl>
 <20111221191211.GE24444@atomide.com>
Message-ID: <201112212045.34850.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 of December 2011 at 20:12:12, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111219 14:41]:
> > Don't use Amstrad Delta custom I/O functions for controlling the device,
> > use GPIO API instead.
> > 
> > While being at it, add missing gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB).
> > 
> > Depends on patch 2/7 "ARM: OMAP1: ams-delta: convert latches to
> > basic_mmio_gpio"
> > 
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Artem, care to ack this one?


BTW, following the get_maintainer.pl script suggestions, I tried to 
include Artem in the Cc: list, but that script provided me with an 
invalid Artem's email address at nokia.com, and I gave up once my email 
gateway refused to accept that message. Now I've verified that several 
half or more year old commits signed by Artem were the sources of that 
apparently outdated information. Looks like the get_maintainer.pl script 
needs improvement, or should be used with care by people who don't 
follow all email address changes ;).

Thanks,
Janusz
