From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 5 Apr 2012 01:51:54 +0200
Subject: i.MX28 die temperature
In-Reply-To: <330B740BA662BF4E8386F534DF556ED8196D1D99@AEDCEXC09.aei.com>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com>
 <20120329023718.GC3254@S2101-09.ap.freescale.net>
 <330B740BA662BF4E8386F534DF556ED8196D1D99@AEDCEXC09.aei.com>
Message-ID: <201204050151.54254.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Randle, Bill,

> On Wednesday, March 28, 2012 7:37 PM Shawn Guo wrote:
> > On Wed, Mar 28, 2012 at 03:13:57PM +0000, Randle, Bill wrote:
> > > Has anyone developed a driver for reading the die temperature from the
> > > i.MX28? I haven't found anything yet in my searching, but didn't want
> > > to duplicate effort if someone has something already.
> > 
> > The mainline kernel has no support for it, but the release from
> > Freescale has.
> > 
> >   arch/arm/mach-mx28/device.c (battery_data)
> >   drivers/power/mxs/ddi_bc_ramp.c
> > 
> > It'd be nice if you can bring it to mainline.
> 
> Thanks for the pointers, Shawn. I'll take a look at the Freescale code.

There's also some code on the linux-iio mailing list for generic MXS LRADC 
stuff. It included LRADC measurements via SYSFS, temperature readings etc.

I started working on it, but didn't finish it yet.

> 
>     -Bill
> 
> 
> This message, including any attachments, may contain
> information that is confidential and proprietary information
> of Advanced Energy Industries, Inc.  The dissemination,
> distribution, use or copying of this message or any of its
> attachments is strictly prohibited without the express
> written consent of Advanced Energy Industries, Inc.
> 

Best regards,
Marek Vasut
