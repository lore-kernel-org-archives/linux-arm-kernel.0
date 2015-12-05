From: yao.yuan@freescale.com (Yao Yuan)
Date: Sat, 5 Dec 2015 06:23:21 +0000
Subject: [PATCH 4/4] ARM: dts: vf610-twr: relicense vf610-twr.dts under
 GPLv2/X11
In-Reply-To: <1448323302-23563-1-git-send-email-stefan@agner.ch>
References: <1448323302-23563-1-git-send-email-stefan@agner.ch>
Message-ID: <BLUPR03MB13440BF1E1451539A75265C830B0@BLUPR03MB134.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 07:57 AM, Stefan Agner wrote:

> GPLv2-only devicetrees make reuse difficult for software components licensed
> under a different license.
> 
> The consensus is that a GPL/X11 dual-license should allow all necessary uses, so
> relicense the vf610-twr.dts file to this combination.
> 
> CCs were acquired using (updated some email addresses):
> git shortlog -sne --no-merges arch/arm/boot/dts/vf610-twr.dts
> 
> CC: Bill Pringlemeir <bpringle@sympatico.ca>
> CC: Chao Fu <B44548@freescale.com>
> CC: Cory Tusar <cory.tusar@pid1solutions.com>
> CC: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> CC: Fugang Duan <B38611@freescale.com>
> CC: Jingchang Lu <b35083@freescale.com>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Xiubo Li <Li.Xiubo@freescale.com>

Acked-by: Yuan Yao <yao.yuan@freescale.com>

By the way the email address:
CC: Xiubo Li <Li.Xiubo@freescale.com>
Jingchang Lu <b35083@freescale.com>
Chao Fu <B44548@freescale.com>
is no longer valid.

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/vf610-twr.dts | 40
> ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-
> twr.dts index 5438ee4..ce937b9 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
