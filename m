From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Sep 2012 15:59:26 -0700
Subject: [GIT PULL] Samsung fixes-3 for v3.6
In-Reply-To: <05be01cd9527$b35c3480$1a149d80$%kim@samsung.com>
References: <05be01cd9527$b35c3480$1a149d80$%kim@samsung.com>
Message-ID: <CAOesGMiJGihDWpQbgJo9FYSM8FF0WY-B4PtnbE2uWwJcjWzjUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Mon, Sep 17, 2012 at 3:56 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd and Olof,
>
> Here is second Samsung fixes for v3.6.
>
> This includes using spin_lock_irqsave in clk_set_parent() to avoid spinlock
> recursion and fixing wrong definitions.
>
> If any problems, please kindly let me know.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:
>
>   Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)
>
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.6-samsung-fixes-2
>
> Julia Lawall (1):
>       ARM: S3C24xx: delete double assignment
>
> Mandeep Singh Baines (1):
>       ARM: SAMSUNG: use spin_lock_irqsave() in clk_set_parent
>
> Peter Senna Tschudin (1):
>       ARM: S3C24XX: removes unnecessary semicolon
>
> Seung-Woo Kim (1):
>       ARM: EXYNOS: fixed SYSMMU setup definition to mate parameter name

We're very late in the release cycle for 3.6, and only critical fixes
should go in -- no cleanups. Please queue those in a
fixes-non-critical branch for 3.7 instead.

Only the one from Mandeep seems to be a real bug fix, I think?


-Olof
