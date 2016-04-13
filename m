From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 13:03:28 +0800
Subject: [PATCH v2] gpio/ls1043a: Add compatible "fsl, qoriq-gpio" for
 ls1043a gpio nodes
In-Reply-To: <1458726442-1851-3-git-send-email-Gang.Liu@nxp.com>
References: <1458726442-1851-1-git-send-email-Gang.Liu@nxp.com>
 <1458726442-1851-3-git-send-email-Gang.Liu@nxp.com>
Message-ID: <20160413050328.GH28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 05:47:21PM +0800, Liu Gang wrote:
> The compatible "fsl,qoriq-gpio" is used by gpio driver:
> drivers/gpio/gpio-mpc8xxx.c to implement general gpio
> functionalities.
> 
> The chip-specific compatible "fsl,ls1043a-gpio" may be
> used to fix potential gpio IP block errata or other
> chip-specific gpio issues.
> 
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>

Changed subject prefix to 'arm64: dts: ls1043a: ...', dropped the space
after 'fsl,', adn then applied the patch.

Yes, arm and arm64 use different prefix style, uppercase vs lowercase.

Shawn
