From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 15:15:10 -0500
Subject: [PATCH 1/3] ARM: dove: drop pinctrl PMU reg property
In-Reply-To: <1393977790-29110-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393977790-29110-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393977790-29110-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140306201510.GJ1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 01:03:08AM +0100, Sebastian Hesselbarth wrote:
> Marvell Dove's pinctrl does require some PMU regs for muxing PMU
> functions to MPP pins. Recently, a discussion started about consolidating
> Power Management Unit (PMU) into a single DT node. As we don't want
> anymore DT ABI in the way, drop the corresponding reg property from
> pinctrl node now. The driver will derive the registers from existing
> reg properties.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org> 
> Cc: Pawel Moll <pawel.moll@arm.com> 
> Cc: Mark Rutland <mark.rutland@arm.com> 
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
> Cc: Kumar Gala <galak@codeaurora.org> 
> Cc: Russell King <linux@arm.linux.org.uk> 
> Cc: Jason Cooper <jason@lakedaemon.net> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: devicetree at vger.kernel.org 
> Cc: linux-arm-kernel at lists.infradead.org 
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to mvebu/dt

thx,

Jason.
