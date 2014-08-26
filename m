From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 26 Aug 2014 15:45:28 +0530
Subject: [PATCH 2/2] ARM: davinci: board-da850-evm: Add needed regulators
 for tlv320aic3106 codec
In-Reply-To: <1406546678-797-2-git-send-email-peter.ujfalusi@ti.com>
References: <1406546678-797-1-git-send-email-peter.ujfalusi@ti.com>
 <1406546678-797-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <53FC5E40.7020904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 04:54 PM, Peter Ujfalusi wrote:
> IOVDD: tps65070's dcdc2
> AVDD and DRVDD: fixed regulator derived from 5V via TPS73701DCQ
> DVDD: fixed regulator derived from 5V via TPS73701DCQ
> 
> This patch needed to be able to probe the audio codec.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c | 13 +++++++++++++

Applied both for v3.18 while fixing the following:

CHECK: Please use a blank line after function/struct/union/enum declarations
#56: FILE: arch/arm/mach-davinci/board-da850-evm.c:845:
 }
+/* Fixed regulator support */

total: 0 errors, 0 warnings, 1 checks, 37 lines checked

Thanks,
Sekhar
