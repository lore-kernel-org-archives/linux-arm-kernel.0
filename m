From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Tue, 3 Nov 2015 22:26:34 +0000
Subject: [PATCH v4] arm64: dts: Added syscon-reboot node for FSL's LS2085A
 SoC
In-Reply-To: <1446235498-4093-1-git-send-email-German.Rivera@freescale.com>
References: <1446235498-4093-1-git-send-email-German.Rivera@freescale.com>
Message-ID: <CY1PR0301MB0748AB5722A44E0D65F5E29F872B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: J. German Rivera [mailto:German.Rivera at freescale.com]
> Sent: Friday, October 30, 2015 3:05 PM
> To: robh+dt at kernel.org; mark.rutland at arm.com; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: Sharma Bhupesh-B45370; Yoder Stuart-B08248; Li Yang-Leo-R58472; Rivera Jose-B46482
> Subject: [PATCH v4] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
> 
> Added sys-reboot node to the FSL's LS2085A SoC DT to leverage
> the ARM-generic reboot mechanism for this SoC. This mechanism
> is enabled through CONFIG_POWER_RESET_SYSCON.

German, one thing I noticed with this patch-- with the name change to
ls2080a, we should update the patch subject and commit message
to reflect that.

Thanks,
Stuart
