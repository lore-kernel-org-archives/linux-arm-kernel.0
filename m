From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Jul 2014 20:47:31 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140702182500.GN24879@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
 <CAMbhsRSm_o78X-+2mfgUfR7pwgaDob75Lcvjfck50kHcagX=cQ@mail.gmail.com>
 <20140702161649.GF24879@arm.com> <53B44979.10100@codeaurora.org>
 <20140702182500.GN24879@arm.com>
Message-ID: <20140702194731.GP410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 07:25:00PM +0100, Will Deacon wrote:

> Partially because we have to maintain the stuff forever, but also because
> it sets precedent for merging more (unremoveable) emulation code in the
> future, which gets proportionally less testing over time.

If testing is a concern would a testsuite help address that?  I'd expect
we could get it run regularly on mainline by someone like Linaro or
Google.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/56c009c1/attachment.sig>
