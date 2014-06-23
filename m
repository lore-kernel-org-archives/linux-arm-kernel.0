From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 23 Jun 2014 17:50:15 -0400
Subject: [PATCH] ARM: dts: kirkwood: fix phy-connection-type for Guruplug
In-Reply-To: <1403555115-13111-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1403555115-13111-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140623215015.GC10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 10:25:15PM +0200, Sebastian Hesselbarth wrote:
> Commit eeb845459a72e792a959278b858f9c417e9995bd
>  ("ARM: dts: kirkwood: set Guruplug phy-connection-type to rgmii-id")
> added phy-connection-type properties to ethernet PHY nodes.
> 
> Actually, the property has to be set for the ethernet port node instead.
> Fix it by moving the corresponding properties to the correct nodes.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Jason,
> 
> this should go in as a fix for v3.16 where above commit appeared first.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
