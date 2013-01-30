From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 30 Jan 2013 15:46:40 -0500
Subject: [PATCH V2] arm: mvebu: Improve the SMP support of the
 interrupt controller
In-Reply-To: <1354740203-26665-1-git-send-email-gregory.clement@free-electrons.com>
References: <1354740203-26665-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130130204640.GT7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 09:43:23PM +0100, Gregory CLEMENT wrote:
> This patch makes the interrupt controller driver more SMP aware for
> the Armada XP SoCs. It adds the support for the per-CPU irq. It also
> adds the implementation for the set_affinity hook.
> 
> Patch initialy wrote by Yehuda Yitschak and reworked by Gregory
> CLEMENT.
> 
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
>  arch/arm/mach-mvebu/irq-armada-370-xp.c |   52 +++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)

reapplied to mvebu/boards ;-)

squashed in Yehuda's fix.

thx,

Jason.
