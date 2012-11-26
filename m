From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Nov 2012 09:31:47 -0800
Subject: [GIT PULL] ARM: ixp4xx: fixes for v3.7
In-Reply-To: <201211261314.32662.arnd@arndb.de>
References: <0Lufa8-1TAtF11yb2-00zw9g@mx.kundenserver.de>
 <201211261314.32662.arnd@arndb.de>
Message-ID: <CAOesGMhRKfhjvhb0u+qADwpSJZbXEhXzbZAFgOdnbkmMgYy0mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 5:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 22 November 2012, Jason Cooper wrote:
>> The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:
>>
>>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.infradead.org/users/jcooper/linux.git tags/ixp4xx_fixes_for_3.7
>>
>> for you to fetch changes up to 0d2c9f0517e915ce03a04e91d3207827e0d274a8:
>>
>>   IXP4xx: use __iomem for MMIO (2012-11-22 03:36:45 +0000)
>>
>> ----------------------------------------------------------------
>> ixp4xx fixes for v3.7
>>
>
> I've merged them into the fixes branch now, thanks a lot for following
> up on these patches!

Ah yes, my bad, I had forgotten about this pull request.

> Olof, I'm undecided whether they are still appropriate for 3.7 since
> we're past the final -rc now. If we want them in, we should probably
> send them to Linus now and let him decide.  For all I can tell, ixp4xx
> is already completely broken without these patches, so there should be
> no harm in including them, but then again " 13 files changed, 59
> insertions(+), 68 deletions(-)" is slightly more than I'd like to send
> at this point.
>
> If you prefer, we can put them into next/fixes-non-critical, but then we
> might want to mark more of them as candidates for stable.

Since the code has been broken for quite a while, I don't see a big
urgency to get it in in the last week of a new release, but I can
easily be persuaded differently. Had I done the pull, I would probably
have merged them into fixes-non-critical myself.

But, as I said, I don't have strong opinions on the matter. :)


-Olof
