From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 15:17:28 -0500
Subject: [PATCH 2/3] devicetree: bindings: drop pinctrl PMU reg property
In-Reply-To: <1393977790-29110-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393977790-29110-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393977790-29110-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140306201728.GK1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 01:03:09AM +0100, Sebastian Hesselbarth wrote:
> Marvell Dove's pinctrl does require some PMU regs for muxing PMU
> functions to MPP pins. Recently, a discussion started about consolidating
> Power Management Unit (PMU) into a single DT node. As we don't want
> anymore DT ABI in the way, drop the corresponding reg property from
> pinctrl binding documentation now.
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
>  Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt  | 2 +-
>  Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/pinctrl

thx,

Jason.
