From: Bill.Randle@aei.com (Randle, Bill)
Date: Thu, 29 Mar 2012 15:52:51 +0000
Subject: i.MX28 die temperature
In-Reply-To: <20120329023718.GC3254@S2101-09.ap.freescale.net>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com>
 <20120329023718.GC3254@S2101-09.ap.freescale.net>
Message-ID: <330B740BA662BF4E8386F534DF556ED8196D1D99@AEDCEXC09.aei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 28, 2012 7:37 PM Shawn Guo wrote:
> On Wed, Mar 28, 2012 at 03:13:57PM +0000, Randle, Bill wrote:
> > Has anyone developed a driver for reading the die temperature from the i.MX28? I haven't found anything yet in my searching, but didn't want to duplicate effort if someone has something already.
> > 
> The mainline kernel has no support for it, but the release from
> Freescale has.
> 
>   arch/arm/mach-mx28/device.c (battery_data)
>   drivers/power/mxs/ddi_bc_ramp.c
> 
> It'd be nice if you can bring it to mainline.

Thanks for the pointers, Shawn. I'll take a look at the Freescale code.

    -Bill


This message, including any attachments, may contain 
information that is confidential and proprietary information 
of Advanced Energy Industries, Inc.  The dissemination,
distribution, use or copying of this message or any of its
attachments is strictly prohibited without the express 
written consent of Advanced Energy Industries, Inc.
