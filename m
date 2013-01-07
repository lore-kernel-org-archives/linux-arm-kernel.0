From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 11:20:34 -0500
Subject: [PATCH v2 1/2] ARM: Dove: Add pinctrl clock to DT
In-Reply-To: <1353957399-28799-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1353921525-25163-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353957399-28799-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130107162034.GH5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 08:16:38PM +0100, Sebastian Hesselbarth wrote:
> During merge of the mvebu patches a clock gate for pinctrl was
> lost. This patch just readds the clock gate.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Axel Lin <axel.lin@ingics.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/boot/dts/dove.dtsi |    1 +
>  1 file changed, 1 insertion(+)

Both (v2) applied to mvebu/fixes

thx,

Jason.
