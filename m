From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 29 Aug 2012 18:18:04 -0500
Subject: [PATCH 2/6] ARM: introduce Kconfig.mach
In-Reply-To: <1346280600-29395-3-git-send-email-robherring2@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-3-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206B1D9F2E7@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 29, 2012 3:50 PM, Rob Herring wrote:
>
> Move all the mach related config options into separate Kconfig.mach file.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/Kconfig      |  529 +------------------------------------------------
>  arch/arm/Kconfig.mach |  528 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 529 insertions(+), 528 deletions(-)
>  create mode 100644 arch/arm/Kconfig.mach

FWIW as far as ep93xx goes..

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks
