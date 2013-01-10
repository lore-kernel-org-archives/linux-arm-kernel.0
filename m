From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Jan 2013 21:03:09 -0500
Subject: [PATCH V2 2/4] arm: mvebu: Add RTC support for Armada 370 and
 Armada XP
In-Reply-To: <1355303186-9267-3-git-send-email-gregory.clement@free-electrons.com>
References: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
 <1355303186-9267-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130110020309.GE5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 10:06:24AM +0100, Gregory CLEMENT wrote:
> The Armada 370 and Armada XP Socs have the same controller that the
> one used in the orion platforms. This patch updates the device tree
> for these SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)

Applied to mvebu/dt

thx,

Jason.
