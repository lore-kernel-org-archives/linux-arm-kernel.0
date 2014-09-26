From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 26 Sep 2014 12:11:58 +0200
Subject: [GIT PULL] arm: mediatek: Add more basic features
In-Reply-To: <20140924181625.GE19284@localhost>
References: <CABuKBeJJ5ijy6CXPHbrzrkgJDVz99BmdACx+wRZ-KbVjKx2kLg@mail.gmail.com>
 <20140924181625.GE19284@localhost>
Message-ID: <CABuKBeKPmwikra2er4ZMGAPdnbV3zgGSHHi3NsAmij1nkBzHHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2014-09-24 20:16 GMT+02:00 Olof Johansson <olof@lixom.net>:
> On Mon, Sep 15, 2014 at 05:59:28PM +0200, Matthias Brugger wrote:
>> Hi Arnd and Olof,
>>
>> Please prepare for the next round of Mediatek patches for the mt6589.
>> This patch set adds some minor changes to the Mediatek mt6589 support.
>>
>> Features are low-level debugging on the mt6589, the addition to the
>> "make dtbs" and multi_v7_defconfig,as well as some small changes in
>> the DTS files.
>
> Hi Matthias,
>
> The contents in this branch look OK to me, but I'd prefer to spread them out
> across some of our branches (most of it is DT, one is defconfig and one is soc stuff).

Do you want me to fix the other pull request I send [0]?
As far as I can see, there are three patches for next/soc and the
remaining four for next/dt.

You want me to resend the pull request and split it in two?

[0] http://www.spinics.net/lists/arm-kernel/msg364271.html

>
> Because of this, I've ended up applying patches manually (cherry-picking them out of this branch).
>
> In other words: Code is merged, but branch is not. Thanks!
>
> (Also, we tend to use a capital ARM: as prefix on patch subjects, I fixed that up).

Ok, thanks for the info. If you want me to resend the aforementioned
pull request, I fix that too.

Thanks,
Matthias

>
>
> -Olof



-- 
motzblog.wordpress.com
