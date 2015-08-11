From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Aug 2015 10:03:42 +0100
Subject: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
In-Reply-To: <55C99D0D.9050605@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
 <1437568344-18889-4-git-send-email-fcooper@ti.com>
 <55B22681.3060000@ti.com> <55C9380D.1060802@ti.com>
 <55C99D0D.9050605@ti.com>
Message-ID: <20150811090342.GG10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 12:28:21PM +0530, Sekhar Nori wrote:
> On Tuesday 11 August 2015 05:17 AM, Franklin S Cooper Jr. wrote:

> > ping. Patches 1 and 2 have already been pulled into Mark's spi tree and are currently in in linux-next.

> Mark, can you apply this patch to your tree as well? Thats the preferred
> route for me.

> If thats not an option for you, can you confirm that the topic/davinci
> branch of your spi tree is an immutable commit I can base my pull
> request to ARM-SoC on?

Why would there be any interdependency between the the two trees, that
would be very unusual?  Adding a new value to DT doesn't need the kernel
to understand it and the driver should be compatible with existing DTs.
If there *is* some dependency that suggests the driver update has
problems...

In any case I don't have a copy of the patch any more.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150811/7da1cd5e/attachment.sig>
