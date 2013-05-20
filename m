From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 13:48:05 -0400
Subject: [PATCH] ARM: dts: mvebu: Fix wrong the address reg value for
 the L2-cache node
In-Reply-To: <1369059207-32210-1-git-send-email-gregory.clement@free-electrons.com>
References: <1369059207-32210-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130520174805.GA31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 04:13:27PM +0200, Gregory CLEMENT wrote:
> During the conversion to the internal-regs' subnode, the L2-cache node
> haven not been converted (due to a wrong choice made by myself during
> the resolution of the merge conflict when I rebased the commit). This
> leads to wrong address for L2 cache which prevent it to be used on
> Armada 370. This commit fix the address reg of the e L2-cache node.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/fixes

thx,

Jason.
