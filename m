From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Sat, 27 Feb 2016 12:03:01 -0800
Subject: [PATCH v3 1/5] arm64: Broadcom Vulcan support
In-Reply-To: <1456555925-11583-1-git-send-email-jchandra@broadcom.com>
References: <56C8C38E.50007@gmail.com>
 <1456555925-11583-1-git-send-email-jchandra@broadcom.com>
Message-ID: <56D200F5.7010505@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/02/16 22:52, Jayachandran C wrote:
> From: Zi Shen Lim <zlim@broadcom.com>
> 
> Add a configuration option and a device tree for Broadcom's Vulcan
> ARM64 processor. vulcan.dtsi has the on-chip blocks like the PCIe
> controller, GICv3 with ITS, PMU, system timer and the pl011 UART.
> vulcan-eval.dts has definitions for a basic evaluation board.
> 
> Vulcan's processor cores support the ARMv8.1 instruction set and
> will use "brcm,vulcan" as the compatible property. The firmware
> has PSCI 0.2 support for cpu wakeup.
> 
> Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
> [ updated and split dts - jchandra at broadcom.com ]
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
> 
> There is a minor update to this patch.
> 
> After some discussions here, it looks like it is necessary to increase the
> PCI mem and mem64 ranges to support all the use cases. We are updating the
> firmware to use these ranges as well.
> 
> Hope it is not too late to fix this, sorry for the late churn.

V2 got merged already into next/dt64 by the arm-soc maintainers, could
you provide an incremental patch to your v2? Thanks!
--
Florian
