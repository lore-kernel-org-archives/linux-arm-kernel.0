From: david@lechnology.com (David Lechner)
Date: Fri, 15 Apr 2016 16:20:51 -0500
Subject: [PATCH 1/3] ARM: DTS: da850: add node for spi0
In-Reply-To: <31522.1460751389@turing-police.cc.vt.edu>
References: <1460586628-25152-1-git-send-email-david@lechnology.com>
 <1460586628-25152-2-git-send-email-david@lechnology.com>
 <5710C176.3040304@ti.com> <57111433.6080402@lechnology.com>
 <31522.1460751389@turing-police.cc.vt.edu>
Message-ID: <57115B33.90509@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 03:16 PM, Valdis.Kletnieks at vt.edu wrote:
> On Fri, 15 Apr 2016 11:17:55 -0500, David Lechner said:
>
>> I omitted this on purpose. For my use case, I am using the SPI as
>> write-only,
>
> So your SPI accesses are fire-and-forget, and nothing ever comes back?

Yes.

> Seems a very dangerous way to design the use case, with no feedback if
> something suddenly goes pear-shaped...

You should tell Sitronix. This is how their display controllers work.

>
> Or do you have ways to verify the status via some method other than SPI?
>

Nope.



I'm working with LEGO MINDSTORMS EV3, a mass-produced robotics system. 
It is what it is. And I have a logic analyzer for when things go 
pear-shaped. ;-)
