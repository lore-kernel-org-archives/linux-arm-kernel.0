From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 11:40:21 +0000
Subject: clps711x patchset
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <201204211140.21564.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, Alexander Shiyan wrote:
> Hello.
> This is patchset contains some cleanups and tricks for CLPS711X ARM target.
> Please review and apply it to kernel tree. Comments are welcome :)

Hi Alexander,

This looks very nice overall, it's certainly good that you can manage to add
support for a new soc with a net removal of lines.

Note that with the current work split, it will be Olof and me who apply
these patches in the end, not Russell, although he will probably have
to something to say about the patches, too, since he has done almost all the
changes to this platform in its more active times.

>From my reading of the git history, very little has happened in clps711x
since about 2005, and we've never had a subarch maintainer for it. Are you
interested in becoming the maintainer for it, or is this more a one-time
effort on your side? I don't expect this to be much work for you, but it
would be nice to have some person that can review the occasional patch
touching multiple platforms.

Do you have any plans to add more stuff to the platform, like additional
SoCs or more board files? Do you see value in having it included in
a single kernel image that runs on various different ARMv4/ARMv5 based
Socs? I assume that the answer to all of these is 'no', but you plan
to do them, we should talk about how to make that happen.

	Arnd
