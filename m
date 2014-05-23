From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 May 2014 15:13:34 -0700
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.16 (incr. #2)
In-Reply-To: <201405240006.33940.arnd@arndb.de>
References: <20140522155123.GT8664@titan.lakedaemon.net>
 <201405240006.33940.arnd@arndb.de>
Message-ID: <CAOesGMg88KrBBpBGzqH-b4sOi-7X=2x3BQBoDqqrMZs+va6ztg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 3:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 22 May 2014, Jason Cooper wrote:
>> The following changes since commit 208f4e0d9bce775fbc7ab08c830d135d3da5777c:
>>
>>   ARM: multi_v5_defconfig: Enable sound modules needed for t5325 (2014-05-05 01:22:11 +0000)
>>
>> are available in the git repository at:
>>
>>   git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.16-2
>>
>> for you to fetch changes up to 0105c9990291587a3b1fecb576f4d9b6728f1191:
>>
>>   ARM: mvebu: enable MSI support in mvebu_v7_defconfig (2014-05-22 14:22:17 +0000)
>
> As discussed with Olof, I'm starting a new next/defconfig branch separate
> from next/boards now, and have merged this one into the new branch.
>
> Still need to figure out how to separate the defconfig changes that are
> already in next/boards from the rest there, but since this one includes
> the other changes, we're good for mvebu.

I don't think we need to bother too much with separating them, we just
make this change going forward from here. It's not perfectly sorted
that way but it turns out we usually have a few things that don't sort
well more or less every release cycle and nobody complains all that
much. :)



-Olof
