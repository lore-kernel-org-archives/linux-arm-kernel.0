From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 21 Apr 2012 16:04:02 +0400
Subject: =?UTF-8?B?UmVbMl06IGNscHM3MTF4IHBhdGNoc2V0?=
In-Reply-To: <201204211140.21564.arnd@arndb.de>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <201204211140.21564.arnd@arndb.de>
Message-ID: <E1SLZ2o-0002iH-SH.shc_work-mail-ru@f105.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 21 Apr 2012 11:40:21 +0000 ?? Arnd Bergmann <arnd@arndb.de>:
> On Saturday 21 April 2012, Alexander Shiyan wrote:
> > Hello.
> > This is patchset contains some cleanups and tricks for CLPS711X ARM target.
> > Please review and apply it to kernel tree. Comments are welcome :)
...
> This looks very nice overall, it's certainly good that you can manage to add
> support for a new soc with a net removal of lines.
> 
> Note that with the current work split, it will be Olof and me who apply
> these patches in the end, not Russell, although he will probably have
> to something to say about the patches, too, since he has done almost all the
> changes to this platform in its more active times.
> 
> From my reading of the git history, very little has happened in clps711x
> since about 2005, and we've never had a subarch maintainer for it. Are you
> interested in becoming the maintainer for it, or is this more a one-time
> effort on your side? I don't expect this to be much work for you, but it
> would be nice to have some person that can review the occasional patch
> touching multiple platforms.
> 
> Do you have any plans to add more stuff to the platform, like additional
> SoCs or more board files? Do you see value in having it included in
> a single kernel image that runs on various different ARMv4/ARMv5 based
> Socs? I assume that the answer to all of these is 'no', but you plan
> to do them, we should talk about how to make that happen.

The new processors in this series as far as I know there is not and no more will be.
Existing processors are still produced and used. We use this processor is 4-5 years
old and still expect to use in the future.

I can look at the new code is correct, but check it can only work on our custom board.

Of the new things I would like to add the ability to use gpiolib with this type of processor.
