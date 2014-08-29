From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Sat, 30 Aug 2014 01:16:14 +0200
Subject: [PATCH] mmc: sunxi: Declare ERASE capability
In-Reply-To: <CAPDyKFq1yzdu19ReECRZzVynHZByN4803WdZ=vjgCnC9F0+MiA@mail.gmail.com>
References: <1408541960-14788-1-git-send-email-wens@csie.org>
 <3728016.4j3Ljjy6eM@dizzy-6.o2s.ch>
 <CAPDyKFq1yzdu19ReECRZzVynHZByN4803WdZ=vjgCnC9F0+MiA@mail.gmail.com>
Message-ID: <3040533.uqhIdSSGxW@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> > I totally agree with you that information about such capabilities should
> > be
> > exposed but maybe it would be wiser to use DT instead of hardcoding it?
> 
> Nope, this is pure software support. No HW config.
Okey!
> What we should do future wise, is to remove the MMC_CAP_ERASE
> entirely. Due to current existing bugs, mainly in mmc core layer
> regarding erase, we can't do it yet.
I see.
> > I mean a WiFi device won't support erase functionality...
> 
> That's already covered by the mmc core layer. No worries.
Splendid!
Ok then. Let's have it in our driver so far until we can get rid of this flag
for good.

cheers
-- 
David Lanzend?rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140830/239fdd5a/attachment.sig>
