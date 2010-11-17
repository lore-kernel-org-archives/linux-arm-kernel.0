From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Wed, 17 Nov 2010 16:18:46 +0200
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
	(try #8)
In-Reply-To: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1290003526.26444.30.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-17 at 21:34 +0800, ext Bryan Wu wrote:
> There are 4 duplicated DPI panel drivers in DSS2 display driver. They are
> similar and a generic DPI panel driver can support all them with specific
> panel configuration. And new DPI panel driver can be easily supported
> by adding panel configurations into generic panel DPI driver.
> 
> This patchset introduces a generic panel DPI driver, remove 3 panel drivers and enable
> generic panel DPI driver in board files. And it is based on 2.6.37-rc2.
> 
> Building with omap2plus_defconfig is successful.
> 
> Keep sharp_ls_panel, since it contains blacklight control code which will be
> moved out later.
> 
> Bryan Wu (3):
>   OMAP: DSS2: Add generic DPI panel display driver
>   OMAP: use generic DPI panel driver in board files
>   OMAP: DSS2: remove generic DPI panel driver duplicated panel drivers

Thanks, looks good. This is now applied to my tree.

Are you also interested in solving the backlight issue? =)

 Tomi
