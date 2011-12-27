From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Dec 2011 15:25:04 -0800
Subject: [GIT PULL 2/5] Tegra devicetree updates for 3.3
In-Reply-To: <201112272243.39791.arnd@arndb.de>
References: <CAOesGMhSEbpcKXv87_cv+1b-wB7g8zmtFR2wMygByuTBv_bmvA@mail.gmail.com>
 <201112272243.39791.arnd@arndb.de>
Message-ID: <CAOesGMi5gEc-KAsEGDc7yw4UowEEAhkFFwKa6LoMvBf5=3WK9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 27, 2011 at 2:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 21 December 2011, Olof Johansson wrote:
>> Hi Arnd,
>>
>> Please pull the following device tree-related updates for tegra for 3.3. Thanks!
>>
>>
>> The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
>>
>> ? Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)
>>
>> are available in the git repository at:
>> ? git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/dt
>>
>
> Pulled into a new next/dt branch, thanks!

Thanks!

> There is a bogus conflict in arch/arm/mach-tegra/Makefile from merging
> two different versions of "arm/tegra: fix variable formatting in makefile".
> The patches are identical, but 317d5330 made it into tegra/dt and
> 584634e3 into tegra/cleanup.
>
> Trivial to fix, but something to watch out for in the future.

Thanks, I just realized how that must have happened -- I had to rebase
to a newer -rc a while back, and must have rebased each branch from
scratch instead of rebasing dt on top of the new rebased cleanup.


-Olof
