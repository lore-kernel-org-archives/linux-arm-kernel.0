From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Jul 2011 09:46:42 -0400 (EDT)
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <20110708090721.GC2414@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
	<4E15ECB6.40100@codeaurora.org>
	<20110707223620.GG20403@n2100.arm.linux.org.uk>
	<4E165597.90002@codeaurora.org>
	<20110708090721.GC2414@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107080941090.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jul 2011, Russell King - ARM Linux wrote:

> There's also platforms where the zImage is loaded at some predetermined
> offset into RAM to give the decompressor room to directly place the
> kernel in its final location too, which will be buggered by
> AUTO_ZRELADDR.

How so?  Loading that zImage at the same predetermined offset will still 
have the same desired effect.  As long as the offset is within 128MB of 
the start of RAM.


Nicolas
