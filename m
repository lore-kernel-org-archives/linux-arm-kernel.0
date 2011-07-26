From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 26 Jul 2011 17:48:06 -0400 (EDT)
Subject: at91sam9g45: Issues while working with RAM that is separated on
	physical address space
In-Reply-To: <CAA2DH4u3n3JmLcnFurQRXbc2Me5aHw2wR4sHUbZOA+zoex3c7Q@mail.gmail.com>
References: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
	<20110722135505.GB25947@n2100.arm.linux.org.uk>
	<CAA2DH4u9GANxUTnTqRzUR=GihNLS8EEDAKm8u8SFZ_Yq48qXOg@mail.gmail.com>
	<CAA2DH4sviHkHEHZTR+0AHP3pToC7fEgTc+irw0vk_WU5q0XEQQ@mail.gmail.com>
	<20110726133702.GA14526@taskit.de>
	<20110726135428.GC1655@n2100.arm.linux.org.uk>
	<CAA2DH4u3n3JmLcnFurQRXbc2Me5aHw2wR4sHUbZOA+zoex3c7Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1107261741090.12766@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2011, P J wrote:

> The mapping of second memory bank is going wrong because of the
> reasons I have said earlier, so my second memory bank gets overlapped
> with the vmalloc region and is ignored. With highemem seems like the
> problem should have been solved but my kernel does not boot with
> highmem enabled.
> 
> Any suggestions ? I'm using Linux 2.6.30..

Highmem support was introduced on ARM in v2.6.29 and became somewhat 
"reliable" on v2.6.31.  In any case, v2.6.30 is more than 2 years old. 
Please try to upgrade your kernel.


Nicolas
