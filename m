From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 13:04:58 +0800
Subject: [PATCH] gpio/ls2080a: Add compatible "fsl, ls2080a-gpio" for
 ls2080a gpio nodes
In-Reply-To: <1458726442-1851-4-git-send-email-Gang.Liu@nxp.com>
References: <1458726442-1851-1-git-send-email-Gang.Liu@nxp.com>
 <1458726442-1851-4-git-send-email-Gang.Liu@nxp.com>
Message-ID: <20160413050458.GI28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 05:47:22PM +0800, Liu Gang wrote:
> The compatible "fsl,qoriq-gpio" is used by gpio driver:
> drivers/gpio/gpio-mpc8xxx.c to implement general gpio
> functionalities.
> 
> The chip-specific compatible "fsl,ls2080a-gpio" may be
> used to fix potential gpio IP block errata or other
> chip-specific gpio issues.
> 
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>

Updated patch subject as below and then applied it.

arm64: dts: ls2080a: Add compatible "fsl,ls2080a-gpio" for ls2080a gpio nodes

Shawn
