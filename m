From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 14:01:58 +0800
Subject: [PATCH 1/4] ARM: dts: vf610: relicense vf???.dtsi under GPLv2/X11
In-Reply-To: <1448323069-23208-2-git-send-email-stefan@agner.ch>
References: <1448323069-23208-1-git-send-email-stefan@agner.ch>
 <1448323069-23208-2-git-send-email-stefan@agner.ch>
Message-ID: <20151124060158.GG11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 03:57:46PM -0800, Stefan Agner wrote:
> GPLv2-only devicetrees make reuse difficult for software components
> licensed under a different license.
> 
> The consensus is that a GPL/X11 dual-license should allow all necessary
> uses, so relicense the vfxxx.dtsi, vf500.dtsi and vf610.dtsi files to
> this combination.
> 
> CCs were acquired using (updated some email addresses):
> git shortlog -sne --no-merges arch/arm/boot/dts/vf???.dtsi
> 
> CC: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> CC: Chao Fu <B44548@freescale.com>
> CC: Cory Tusar <cory.tusar@pid1solutions.com>
> CC: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> CC: Frank Li <Frank.Li@freescale.com>
> CC: Fugang Duan <B38611@freescale.com>
> CC: Huang Shijie <b32955@freescale.com>
> CC: Jingchang Lu <jingchang.lu@freescale.com>
> CC: Lucas Stach <l.stach@pengutronix.de>
> CC: Sanchayan Maity <maitysanchayan@gmail.com>
> CC: Shawn Guo <shawnguo@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>

> CC: Stephen Warren <swarren@wwwdotorg.org>
> CC: Xiubo Li <Li.Xiubo@freescale.com>
> CC: Yuan Yao <yao.yuan@freescale.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
