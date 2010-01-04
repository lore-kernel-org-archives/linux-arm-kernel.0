From: siarhei.siamashka@nokia.com (Siarhei Siamashka)
Date: Mon, 4 Jan 2010 17:18:54 +0200
Subject: [RFC PATCH 2/2] ARM: VFP: preserve the HW context when calling
	signal handlers
In-Reply-To: <20100104142549.GF9107@n2100.arm.linux.org.uk>
References: <c70d85c1a0b20b5f227f34b32db674c7b362d72d.1242734510.git.imre.deak@nokia.com>
	<201001041615.26490.siarhei.siamashka@nokia.com>
	<20100104142549.GF9107@n2100.arm.linux.org.uk>
Message-ID: <201001041718.55150.siarhei.siamashka@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 January 2010 16:25:49 ext Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2010 at 04:15:26PM +0200, Siarhei Siamashka wrote:
> > On Saturday 13 June 2009 20:04:06 ext Russell King - ARM Linux wrote:
> > > - wait for a new patch which includes these other registers and not
> > > have any ABI visible changes to contend with
> >
> > Sorry for bumping this old thread, but what is the current status of
> > these patches?
>
> What happened was that the 2nd option was decided upon, and then the
> thread died, and probably everyone forgot about it.
>
> So, I'm doing exactly what I said I'd do in the second option.  I'm just
> still waiting some six months on...

OK, it's understandable. The issue just got a bit more popular now than it
used to be six months ago.

> If someone comes up with a tested patch, then its something we should
> sort out.

Thanks for clarifying the situation.

For now I'll keep advising people to use old Imre's patches (1st option) until
it is decided who, how, and when is going to fix it in a right way (2nd
option).

-- 
Best regards,
Siarhei Siamashka
