From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Wed, 05 Feb 2014 14:01:33 +0100
Subject: [PATCH v2 0/6] ARM: sunxi: Add driver for SD/MMC hosts found on
 allwinner sunxi SOCs
In-Reply-To: <20140205103949.GC3192@lukather>
References: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch>
 <20140205103949.GC3192@lukather>
Message-ID: <1676482.sbjAhaSLaV@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime
> I have four comments here:
>   - Read Documentation/SubmittingPatches, especially Section 5 and 12
>     (hints, you forgot the clock maintainers for your clock patches
>     and you didn't put any signed-off-by tags)
Oops. I added signed-offs now
>   - You ignored pretty much all the comments that were made during the
>     review of the first version. Go through
Uh? I just fixed the commits and squashed them together for easier handling.
I'm even using mmc_of_parse now...
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/219339.
> html and address the comments that were made.
>   - Each of your patches should compile. Fix the order of your
>     patches.
Done.
>   - Submit a v3, with the changes you made. Otherwise we have no way
>     of knowing what have been fixed and what didn't
Too many patches would be bloaty.
That's why I've squashed them into small and corrected patches.

> Looking forward for the next iteration!
Good :-)
You can have a look at the recent status here:
http://git.o2s.ch/?p=linux-next.git;a=shortlog;h=refs/heads/20140205

cheers
David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/d03c7f13/attachment.sig>
