From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 18:39:23 -0400
Subject: [PATCH] ARM: mvebu: Fix the Aurora L2 cache node with the
 required cache-unified property
In-Reply-To: <1412588276-4514-1-git-send-email-gregory.clement@free-electrons.com>
References: <1412588276-4514-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141101223923.GC3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 11:37:56AM +0200, Gregory CLEMENT wrote:
> The L2 cache controller on the Armada 370 and Armada XP SoCs is a
> unified cache. Moreover, the Aurora cache controller is compatible
> with the L2x0 cache controller: the "cache-unified" property is
> required by its binding.
> 
> This patch fixes the Aurora L2 cache node for the Armada 370 and
> Armada XP SoCs by adding this property.
> 
> Reported-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 1 +
>  arch/arm/boot/dts/armada-xp.dtsi  | 1 +
>  2 files changed, 2 insertions(+)

Applied to mvebu/dt with Sebastian's Ack.

thx,

Jason.
