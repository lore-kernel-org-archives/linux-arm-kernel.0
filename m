From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 12:27:11 +0200
Subject: [PATCH 05/14] ARM: at91: add pinctrl support
In-Reply-To: <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <504F11FF.4030903@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 03:02 PM, Jean-Christophe PLAGNIOL-VILLARD :
> This is also include the gpio controller as the IP share both.
> Each soc will have to describe the SoC limitation and pin configuration via
> DT.
> 
> This will allow to do not need to touch the C code when adding new SoC if the
> IP version is supported.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

I know that a v2 is being cooked on your side, (with some chunks of
comments from Linus, Richard and me inside) so, I wait for this new
revision with delight ;-)

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

[..]

Bye,
-- 
Nicolas Ferre
