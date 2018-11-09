From: horia.geanta@nxp.com (Horia Geanta)
Date: Fri, 9 Nov 2018 06:05:24 +0000
Subject: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
Message-ID: <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/2018 3:11 AM, Marc Gonzalez wrote:
> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
> which is not set. Enable FSL_MC_BUS, and build FSL_MC_DPIO and
> CRYPTO_DEV_FSL_DPAA2_CAAM as modules.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Reviewed-by: Horia Geant? <horia.geanta@nxp.com>

Thanks,
Horia
