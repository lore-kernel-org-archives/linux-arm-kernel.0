From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 12:48:45 +0800
Subject: [PATCH v2] gpio/ls1021a: Add gpio support for ls1021a platform
In-Reply-To: <1458726442-1851-2-git-send-email-Gang.Liu@nxp.com>
References: <1458726442-1851-1-git-send-email-Gang.Liu@nxp.com>
 <1458726442-1851-2-git-send-email-Gang.Liu@nxp.com>
Message-ID: <20160413044845.GG28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 05:47:20PM +0800, Liu Gang wrote:
> Add gpio nodes for ls1021a platform dts file. The gpio
> IP block of the ls1021a can be supported by the code
> drivers/gpio/gpio-mpc8xxx.c.
> 
> The compatible "fsl,qoriq-gpio" is used by gpio driver:
> drivers/gpio/gpio-mpc8xxx.c to implement general gpio
> functionalities.
> 
> The chip-specific compatible "fsl,ls1021a-gpio" may be
> used to fix potential gpio IP block errata or other
> chip-specific gpio issues.
> 
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>

Changed subject prefix to 'ARM: dts: ls1021a: ...', and applied the
patch.

Shawn
