From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Sep 2012 07:40:23 -0700
Subject: [GIT PULL] Samsung fixes-3 for v3.6
In-Reply-To: <50587612.4030304@samsung.com>
References: <50587612.4030304@samsung.com>
Message-ID: <CAOesGMgEPJ2XRN7_TDtpbw=-iyjD-yHtN=NYLjK6KWo16yj7Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 6:24 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd, Olof
>
> This is re-sending Samsung fixes-3 I talked to Olof before.
>
> The branch is including two commits are using spin_lock_{irqsave,
> irqrestore} in clk_set_parent() and clk_set_rate() to avoid spinlock
> recursion/locking.
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
> v3.6-samsung-fixes-3

Thanks, pulled!


-Olof
