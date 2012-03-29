From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 29 Mar 2012 10:37:20 +0800
Subject: i.MX28 die temperature
In-Reply-To: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com>
Message-ID: <20120329023718.GC3254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 03:13:57PM +0000, Randle, Bill wrote:
> Has anyone developed a driver for reading the die temperature from the i.MX28? I haven't found anything yet in my searching, but didn't want to duplicate effort if someone has something already.
> 
The mainline kernel has no support for it, but the release from
Freescale has.

  arch/arm/mach-mx28/device.c (battery_data)
  drivers/power/mxs/ddi_bc_ramp.c

It'd be nice if you can bring it to mainline.

-- 
Regards,
Shawn
