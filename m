From: stefan@agner.ch (Stefan Agner)
Date: Wed, 02 Dec 2015 13:48:52 -0800
Subject: [PATCH 0/4] ARM: dts: vf610: relicense the device trees under
 GPLv2/X11
In-Reply-To: <1448323069-23208-1-git-send-email-stefan@agner.ch>
References: <1448323069-23208-1-git-send-email-stefan@agner.ch>
Message-ID: <3247a5110998c32c64e4e39e64fcb700@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[added latest email address of Matt Porter]

There are only a few Acks missing.

I still miss an answer from a Freescale developer. Yuan, Cosmin or
Frank, any chance to get an ack on this?

--
Stefan


On 2015-11-23 15:57, Stefan Agner wrote:
> The GPLv2 license makes it impractical for other software components
> licensed under another license to use our device trees. To fix this,
> and make our device tree usable by other software components, relicense
> them under a GPLv2/X11 dual-license.
> 
> In order to get this accepted, we *need* all contributors to the Vybrid
> device tree files to send an ack to the patches applying on a file they
> contributed on.
> 
> I think some Freescale email addresses are not valid anymore, can someone
> from Freescale make an ack on their behalf?
> 
> The needed Acked-by by device tree are:
> 
> vf???.dtsi:
>   Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>   Chao Fu <B44548@freescale.com>
>   Cory Tusar <cory.tusar@pid1solutions.com>
>   Cosmin Stoica <cosminstefan.stoica@freescale.com>
>   Frank Li <Frank.Li@freescale.com>
>   Fugang Duan <B38611@freescale.com>
>   Huang Shijie <b32955@freescale.com>
>   Jingchang Lu <jingchang.lu@freescale.com>
>   Lucas Stach <l.stach@pengutronix.de>
>   Sanchayan Maity <maitysanchayan@gmail.com>
>   Shawn Guo <shawnguo@kernel.org>
>   Stephen Warren <swarren@wwwdotorg.org>
>   Xiubo Li <Li.Xiubo@freescale.com>
>   Yuan Yao <yao.yuan@freescale.com>
> 
> vf610-colibri:
>   Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>   Cory Tusar <cory.tusar@pid1solutions.com>
>   Sanchayan Maity <maitysanchayan@gmail.com>
> 
> vf610-cosmic:
>   Cory Tusar <cory.tusar@pid1solutions.com>
>   Matt Porter <matt.porter@linaro.org>
>   Olof Johansson <olof@lixom.net>
>   Shawn Guo <shawnguo@kernel.org>
> 
> vf610-twr:
>   Bill Pringlemeir <bpringle@sympatico.ca>
>   Chao Fu <B44548@freescale.com>
>   Cory Tusar <cory.tusar@pid1solutions.com>
>   Cosmin Stoica <cosminstefan.stoica@freescale.com>
>   Fugang Duan <B38611@freescale.com>
>   Jingchang Lu <b35083@freescale.com>
>   Shawn Guo <shawnguo@kernel.org>
>   Xiubo Li <Li.Xiubo@freescale.com>
> 
> CC: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> CC: Bill Pringlemeir <bpringle@sympatico.ca>
> CC: Chao Fu <B44548@freescale.com>
> CC: Cory Tusar <cory.tusar@pid1solutions.com>
> CC: Cosmin Stoica <cosminstefan.stoica@freescale.com>
> CC: Frank Li <Frank.Li@freescale.com>
> CC: Fugang Duan <B38611@freescale.com>
> CC: Huang Shijie <b32955@freescale.com>
> CC: Jingchang Lu <b35083@freescale.com>
> CC: Jingchang Lu <jingchang.lu@freescale.com>
> CC: Lucas Stach <l.stach@pengutronix.de>
> CC: Matt Porter <matt.porter@linaro.org>
> CC: Olof Johansson <olof@lixom.net>
> CC: Sanchayan Maity <maitysanchayan@gmail.com>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Stephen Warren <swarren@wwwdotorg.org>
> CC: Xiubo Li <Li.Xiubo@freescale.com>
> CC: Yuan Yao <yao.yuan@freescale.com>
> 
> Stefan Agner (4):
>   ARM: dts: vf610: relicense vf???.dtsi under GPLv2/X11
>   ARM: dts: vf610-colibri: relicense vf*colibri* under GPLv2/X11
>   ARM: dts: vf610-cosmic: relicense vf610-cosmic.dts under GPLv2/X11
>   ARM: dts: vf610-twr: relicense vf610-twr.dts under GPLv2/X11
> 
>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi   | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vf-colibri.dtsi           | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vf500-colibri-eval-v3.dts | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vf500-colibri.dtsi        | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vf500.dtsi                | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vf610-colibri-eval-v3.dts | 42 +++++++++++++++++++++++++----
>  arch/arm/boot/dts/vf610-colibri.dtsi        | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vf610-cosmic.dts          | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vf610-twr.dts             | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vf610.dtsi                | 40 ++++++++++++++++++++++++---
>  arch/arm/boot/dts/vfxxx.dtsi                | 40 ++++++++++++++++++++++++---
>  11 files changed, 397 insertions(+), 45 deletions(-)
