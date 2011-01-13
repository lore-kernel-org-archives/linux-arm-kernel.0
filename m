From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 13 Jan 2011 15:36:02 +0100
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <20110113100407.GB24149@n2100.arm.linux.org.uk>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
	<4D2D1942.4050905@ahsoftware.de>
	<AANLkTimAFp7ORrJLw2d8-i5pK0MZGTyAN5kmRR37ky1v@mail.gmail.com>
	<alpine.LFD.2.00.1101121314470.25498@xanadu.home>
	<20110112184258.GH11039@n2100.arm.linux.org.uk>
	<4D2E928D.9030208@ahsoftware.de>
	<20110113100407.GB24149@n2100.arm.linux.org.uk>
Message-ID: <4D2F0DD2.7030801@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 13.01.2011 11:04, schrieb Russell King - ARM Linux:

>> At least I like that feature since it is available and won't miss it now. ;)
>
> The feature isn't available if it doesn't work.  It's not going to get
> fixed for 2.6.38 - it'll be 2.6.39 due to the timing and complexity of
> the problem.

I just wanted to express that I like that feature a lot and I didn't 
wanted to ask for a quick fix nor did I wanted to make pressure.

I've tried a the patch from Rabin Vincent (along with an alignment) and 
it works. It might not be the best solution and I certainly waste some 
memory (no free), but I don't care.

Regards,

Alexander
