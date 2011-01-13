From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 13 Jan 2011 06:50:05 +0100
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <20110112184258.GH11039@n2100.arm.linux.org.uk>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
	<4D2D1942.4050905@ahsoftware.de>
	<AANLkTimAFp7ORrJLw2d8-i5pK0MZGTyAN5kmRR37ky1v@mail.gmail.com>
	<alpine.LFD.2.00.1101121314470.25498@xanadu.home>
	<20110112184258.GH11039@n2100.arm.linux.org.uk>
Message-ID: <4D2E928D.9030208@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Am 12.01.2011 19:42, schrieb Russell King - ARM Linux:

> As the overall feeling at the time was "don't use large initrds" it's
> something I've never really cared about - and I'm still of the opinion
> that 16MB of compressed initrd/initramfs is rather silly.

Hmm, sorry, I have to disagree. ;)
E.g. 12MB out of the 16MB in the initramfs I've used are modules.
I've also created some larger initramfs wich included  X11 and such, and 
I find it very convenient to use the initramfs to include a rootfs in 
the the kernel and so only have to handle one file for all. E.g. just 
load the kernel with the included rootfs via tftp and you are done.

Sure this can all be done using an external initrd, but that is much 
less comfortable to use.

At least I like that feature since it is available and won't miss it now. ;)

Regards,

Alexander
