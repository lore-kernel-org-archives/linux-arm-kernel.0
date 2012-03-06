From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 6 Mar 2012 18:05:43 +0800
Subject: [GIT PULL][v3.4] pull request on arch-pxa for regulator branch
In-Reply-To: <CAN1soZxJO8sGZwq5LhuEOxt3uEN=s1cAOSXfbR8L5r8Hpc+t-w@mail.gmail.com>
References: <CAN1soZxJO8sGZwq5LhuEOxt3uEN=s1cAOSXfbR8L5r8Hpc+t-w@mail.gmail.com>
Message-ID: <CAN1soZxrEm+7wvNmS8s0HSu6VYqmK1bkvGBXzWjk8E8_27ozpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 2:08 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> Hi Arnd,
>
> Please help to pull these from arch-pxa tree.
>
> The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:
>
> ?Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)
>
> are available in the git repository at:
> ?git://github.com/hzhuang1/linux.git regulator
>
> Heiko St?bner (2):
> ? ? ?pxa: magician/hx4700: Convert to gpio-regulator from bq24022
> ? ? ?regulator: Remove bq24022 regulator driver
>
> ?arch/arm/configs/magician_defconfig | ? ?2 +-
> ?arch/arm/mach-pxa/hx4700.c ? ? ? ? ?| ? 33 ++++++--
> ?arch/arm/mach-pxa/magician.c ? ? ? ?| ? 33 ++++++--
> ?drivers/regulator/Kconfig ? ? ? ? ? | ? ?8 --
> ?drivers/regulator/Makefile ? ? ? ? ?| ? ?1 -
> ?drivers/regulator/bq24022.c ? ? ? ? | ?162 -----------------------------------
> ?include/linux/regulator/bq24022.h ? | ? 24 -----
> ?7 files changed, 55 insertions(+), 208 deletions(-)
> ?delete mode 100644 drivers/regulator/bq24022.c
> ?delete mode 100644 include/linux/regulator/bq24022.h

Hi Arnd,

Please ignore this pull request. I'm sorry on this.

Best Regards
Haojian
