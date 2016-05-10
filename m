From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 May 2016 14:14:45 +0200
Subject: [GIT PULL] Ux500 defconfig updates for v4.7
In-Reply-To: <24266746.WXjeqcnmtv@wuerfel>
References: <CACRpkdaf39+gQzBb5U9gM5n17QwsNd7FxTbd3J+hLcuBNczKWA@mail.gmail.com>
 <24266746.WXjeqcnmtv@wuerfel>
Message-ID: <CACRpkdb6t3QEk6PfTLUXTCCNVWPvq+=BVb1DKJY7q-9HU7+Haw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 2:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 02 May 2016 10:49:06 Linus Walleij wrote:
>> Ux500 defconfig update for v4.7:
>> - Remove the unused MACH_UX500_DT option from the multi_v7 defconfig
>> - Remove staging driver from u8500_defconfig
>> - Update sensor support in u8500_defconfig
>>
>
> I was going to pull this today but noticed that this involves a backmerge
> of v4.6-rc6. Can you rebase this on 4.6-rc3 or earlier to avoid the backmerge?

Of course. enjoy:

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-defconfig-armsoc2

for you to fetch changes up to 35bee33355db8347d5f84caef9d2ddde200b8ba6:

  ARM: u8500_defconfig: update sensor config (2016-05-10 14:10:52 +0200)

----------------------------------------------------------------
Ux500 defconfig update for v4.7:
- Remove the unused MACH_UX500_DT option from the multi_v7 defconfig
- Remove staging driver from u8500_defconfig
- Update sensor support in u8500_defconfig

----------------------------------------------------------------
Lee Jones (1):
      ARM: multi_v7_defconfig: Remove unused Kconfig option MACH_UX500_DT

Linus Walleij (2):
      ARM: u8500_defconfig: remove staging from defconfig
      ARM: u8500_defconfig: update sensor config

 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/u8500_defconfig    | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

Yours,
Linus Walleij
