From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 25 Nov 2012 19:06:19 -0800 (PST)
Subject: [PATCH v5 00/15] shmobile DT initialisation of INTC and GIC
In-Reply-To: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <87d2z1vza0.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Iwamatsu-san

> Hi, simon and Magnus.
> 
> I updated patch series for shmobile DT support.
> This version fixes definition of interrupt-controller. By this, I fixed
> external interrupt issuse on sh7372.
> And update r8a7740 and sh73a0 DT INTC init code to reduce the number of #ifdefs.
> 
> ---
> 
> The aims of this series are:
> 
> * Adding DT support to INTC
> * Allowing relevant ARM shmobile SoCs to use DT to initialise INTC
> * Allowing relevant ARM shmobile boards to use DT to initialise INTC
> * Allowing the sh73a0 SoC use DT to initialise GIC
> * Allowing the sh73a0 SoC use DT to initialise GIC, which in
>   turn allows the kzm9g board to use DT to initialise GIC
> 
> Nobuhiro Iwamatsu (12):
>   ARM: mach-shmobile: Add support OF for INTC of shmobile
>   SH: intc: Add support OF of IRQ
>   ARM: mach-shmobile: Add support OF of INTC for r8a7740
>   ARM: mach-shmobile: Add support OF of INTC for sh73a0
>   ARM: mach-shmobile: Add support OF of INTC for sh7372
>   ARM: mach-shmobile: Add DT table of INTC for sh73a0
>   ARM: mach-shmobile: Add DT table of INTC for sh7372
>   ARM: mach-shmobile: Add DT table of INTC for r8a7740
>   ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva
>   ARM: shmobile: Include DTSI of sh73a0 to kzm9g board
>   ARM: shmobile: r8a7740: Use DT initialisation of INTC
>   ARM: shmobile: sh7372: Use DT initialisation of INTC
> 
> Simon Horman (3):
>   ARM: shmobile: kzm9g: Use DT initialisation of INTC
>   ARM: shmobile: Add DT table of GIC for sh73a0
>   ARM: shmobile: sh73a0: Use DT for GIC

This is not super important, but
did you check your patch by  ./scripts/checkpatch.pl ?

Occasionally it may be unavoidable, but this type of patches can be.


Best regards
---
Kuninori Morimoto
