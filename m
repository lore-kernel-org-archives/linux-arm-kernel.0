From: simon@sequanux.org (Simon Guinot)
Date: Thu, 5 May 2011 15:06:34 +0000
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <alpine.LFD.2.00.1105040940410.24613@xanadu.home>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<20110503205056.GA13075@gentoodev.compulab.local>
	<BANLkTimQM_J2ZbDjAewUsp+XSEP+x+eniA@mail.gmail.com>
	<BANLkTinybLSF418PsocXR6dwuaksv_+UCQ@mail.gmail.com>
	<20110504080924.GX19806@kw.sim.vm.gnt>
	<alpine.LFD.2.00.1105040940410.24613@xanadu.home>
Message-ID: <20110505150634.GC19806@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, May 04, 2011 at 09:51:27AM -0400, Nicolas Pitre wrote:
> On Wed, 4 May 2011, Simon Guinot wrote:
> 
> > Hi Hirundo,
> > 
> > On Wed, May 04, 2011 at 10:54:52AM +0800, Hirundo Cam wrote:
> > > Hi Mike and Simon,
> > > 
> > > I've send a machine submit to arm-linux, it generated the mach-types as
> > > 
> > > [stripped]
> > > mx51_moray		MACH_MX51_MORAY		MX51_MORAY		3484
> > > thales_cbc		MACH_THALES_CBC		THALES_CBC		3485
> > > bluepoint		MACH_BLUEPOINT		BLUEPOINT		3486
> > > dir665			MACH_DIR665		DIR665			3487
> > > 
> > > Is this correct for the DIR665 board using mv88f6281 chips?
> > 
> > It looks correct.
> 
> It may look correct, but I'll ask that you hang to it for a while as 
> there is a desire to stop the addition of such board specific files to 
> the kernel and move towards a solution such as device tree instead to 
> represent those board details.

For my curiosity, how a device tree kernel will deal with ATAGs ?
Is there a compatibility layer planned ?

I mean... For now, the boards on market are not providing a device tree
capable bootloader. Without a compatibility layer, the kernel support
for this boards can't rely on device tree.

I assume it is the dir665 case.

> 
> I think that Kirkwood is actually a good case for device tree as the 
> differences between boards is really simple as it usually boils down to 
> different GPIO usage and MPP assignments.  If someone would like to 
> contribute to the DT effort on ARM then this would be a nice and easy 
> target to convert over.

I am still not familiar with the device tree format and usage but I will
have a look.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110505/228645f9/attachment-0001.sig>
