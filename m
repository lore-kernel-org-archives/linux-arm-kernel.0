From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Mar 2014 23:00:53 -0500
Subject: [PATCH 1/4] ARM: dove: add system controller node
In-Reply-To: <1393536486-3827-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393536486-3827-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140304040053.GD1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 10:28:02PM +0100, Sebastian Hesselbarth wrote:
> This adds a DT node for the system-controller found on Marvell Dove
> SoCs.
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
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

Applied to mvebu/dt

thx,

Jason.
