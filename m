From: hs@denx.de (Heiko Schocher)
Date: Thu, 05 Jul 2012 14:43:08 +0200
Subject: [PATCH] ARM: davinci: cp_intc: Add OF support for TI interrupt
 controller
In-Reply-To: <1341342970-27535-1-git-send-email-nsekhar@ti.com>
References: <1341342970-27535-1-git-send-email-nsekhar@ti.com>
Message-ID: <4FF58BDC.6060802@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sekhar,

On 03.07.2012 21:16, Sekhar Nori wrote:
> From: Heiko Schocher<hs@denx.de>
>
> Add a function to initialize the Common Platform Interrupt Controller
> (cp_intc) from TI used on OMAP-L1x SoCs using a device tree node.
>
> Signed-off-by: Heiko Schocher<hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Wolfgang Denk<wd@denx.de>
> Cc: Sergei Shtylyov<sshtylyov@mvista.com>
> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
> ---
>   .../devicetree/bindings/arm/davinci/cp-intc.txt    |   27 ++++++++++++++++++++
>   arch/arm/mach-davinci/cp_intc.c                    |   16 +++++++++---
>   arch/arm/mach-davinci/include/mach/cp_intc.h       |    1 +
>   3 files changed, 41 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/cp-intc.txt

Thanks!

Tested on the enbw_cmc board.

Sent the updated "ARM: davinci: add support for the am1808 based enbw_cmc"
based on this patch soon.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
