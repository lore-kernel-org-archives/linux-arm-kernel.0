From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 01:52:33 -0700
Subject: [GIT PULL] ARM: bcm281xx firmware tags
In-Reply-To: <20130411065227.GA31465@quad.lixom.net>
References: <1362451632-18806-1-git-send-email-csd@broadcom.com>
 <201303060631.03782.arnd@arndb.de> <5136F816.2070909@broadcom.com>
 <201303061128.57127.arnd@arndb.de> <5165A271.6060407@broadcom.com>
 <20130411065227.GA31465@quad.lixom.net>
Message-ID: <CAOesGMiiDei3HOop4YkiE2qw1R5opBpRYJEU0Vp3izEyB=r=Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 11:52 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Apr 10, 2013 at 10:33:37AM -0700, Christian Daudt wrote:
>> Hi Arnd, Olof,
>>  Please pull the branch below - it contains the BCM281xx l2 cache
>> enabling code.
>>
>>  Thanks,
>>    csd
>>
>>
>> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
>>
>>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
>>
>> are available in the git repository at:
>>
>>   git://github.com/broadcom/bcm11351.git tags/fw-for-3.10
>
> Thanks, pulled into next/soc (local branch name bcm/smc-l2)

Based on later thread about the exynos smc ops, I moved this branch
over to next/firmware instead.


-Olof
