From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Fri, 15 Apr 2016 16:16:29 -0400
Subject: [PATCH 1/3] ARM: DTS: da850: add node for spi0
In-Reply-To: <57111433.6080402@lechnology.com>
References: <1460586628-25152-1-git-send-email-david@lechnology.com>
 <1460586628-25152-2-git-send-email-david@lechnology.com>
 <5710C176.3040304@ti.com> <57111433.6080402@lechnology.com>
Message-ID: <31522.1460751389@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Apr 2016 11:17:55 -0500, David Lechner said:

> I omitted this on purpose. For my use case, I am using the SPI as
> write-only,

So your SPI accesses are fire-and-forget, and nothing ever comes back?
Seems a very dangerous way to design the use case, with no feedback if
something suddenly goes pear-shaped...

Or do you have ways to verify the status via some method other than SPI?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/3af71d9c/attachment.sig>
