From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 4 Dec 2014 20:01:36 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141204184033.GI2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <201412041934.03384@pali>
 <20141204184033.GI2817@atomide.com>
Message-ID: <201412042001.36805@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 19:40:34 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141204 10:36]:
> > see last mail in thread (I CCed you):
> > "[PATCH] ARM: /proc/cpuinfo: Use DT machine name when
> > possible"
> > 
> > There is already some layer for converting ATAGs to DTB and
> > it is in decompresser:
> > arch/arm/boot/compressed/atags_to_fdt.c
> > 
> > I do not know if it can help us to provide /proc/cpuinfo and
> > /proc/atags in DT boot, but at least this this transfer
> > cmdline and mem ATAGs to DBT.
> 
> Yes that makes sense to me. Sorry forgot about that piece of
> code as I have not tinkered with arch/arm/boot/compressed/*
> for a few years.
> 

I did not know about that code in compressed too...

> It sounds like there may be some regression also if the
> cmdline is not being passed like it already should. But I
> assume you already figured that out and have some patches
> coming :)
> 
> Regards,
> 
> Tony

I did not start find out why it not working (do not have time 
now), but at least I know where to start looking for it.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/8e596415/attachment.sig>
