From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 19 May 2014 10:45:45 -0400
Subject: [PATCH v3 4/4] ARM: multi_v5: Enable LaCie 2Big and 5Big
 Network v2
In-Reply-To: <5379C93F.8050302@gmail.com>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-8-git-send-email-andrew@lunn.ch>
 <5379C93F.8050302@gmail.com>
Message-ID: <20140519144545.GI27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 11:05:03AM +0200, Sebastian Hesselbarth wrote:
> [Added arm at kernel.org so they can spot the patch more easily]

Thanks, but we're really only worried about multi_v7_defconfig.
multi_v5_defconfig hasn't proven to be conflict-prone yet.

thx,

Jason.

> On 05/15/2014 04:23 PM, Andrew Lunn wrote:
> >Enable building LaCie 2Big and 5Big Network v2 in the multi v5 kernel.
> >
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >---
> >  arch/arm/configs/multi_v5_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> >index 5ebfa8bf8509..02d4e79826d3 100644
> >--- a/arch/arm/configs/multi_v5_defconfig
> >+++ b/arch/arm/configs/multi_v5_defconfig
> >@@ -11,6 +11,7 @@ CONFIG_MODULE_UNLOAD=y
> >  # CONFIG_ARCH_MULTI_V7 is not set
> >  CONFIG_ARCH_MVEBU=y
> >  CONFIG_MACH_KIRKWOOD=y
> >+CONFIG_MACH_NETXBIG=y
> >  CONFIG_ARCH_MXC=y
> >  CONFIG_MACH_IMX25_DT=y
> >  CONFIG_MACH_IMX27_DT=y
> >
> 
