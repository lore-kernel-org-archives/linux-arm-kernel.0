From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 07 Jun 2014 20:49:18 +0200
Subject: PXA 2xx devictree port and clock infrastructure
In-Reply-To: <20140605030122.GA27682@og3k> (Andrew Ruder's message of "Thu, 5
 Jun 2014 05:01:22 +0200")
References: <87zji3cr3d.fsf@free.fr> <20140605030122.GA27682@og3k>
Message-ID: <87bnu4zhap.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Ruder <andy@aeruder.net> writes:

> On Tue, May 27, 2014 at 03:02:14PM +0200, Robert Jarzmik wrote:
>> I'm playing with devicetree to port the mioa701 machine code to devicetree (or
>> rather to eliminate the mioa701 machine code).
>
> Sorry for the late response, but for what its worth I have an entire
> line of boards running on device-tree for PXA270.  Even better, they are
> FIT booted out of U-Boot so I can use the same kernel on at least 4 (and
> growing) different pieces of hardware.  Some of the patches are in
> really sorry shape, but I'm just now trying to get them cleaned up for
> inclusion (just sent the first wave to netdev today).

This would Arnd's solution (a).
I will attempt solution (c), and send today what I've got so far.

> I've gone ahead and pushed everything up to my personal github
> repository in the meantime - it will probably be rebased frequently
> while I get things cleaned up.
Thanks.

--
Robert
