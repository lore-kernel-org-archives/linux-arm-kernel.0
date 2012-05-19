From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 May 2012 23:47:44 -0700
Subject: [GIT PULL][for 3.5] pull request of board-specific branch in
 arch-pxa
In-Reply-To: <CAN1soZyM-YQ9EX66EY_fTwPncokra9NpB6QEZ2ExCGizKk9MAA@mail.gmail.com>
References: <CAN1soZyM-YQ9EX66EY_fTwPncokra9NpB6QEZ2ExCGizKk9MAA@mail.gmail.com>
Message-ID: <CAOesGMj-ZTj3BE7WWjBM9BZYUV+a7PRMMN8B5+Xk0f2KiF4DtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Sun, May 13, 2012 at 6:42 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Hi Arnd & Olof,
>
> Please help to merge board-specific branch in arch-pxa git tree.
>
> The following changes since commit 36be50515fe2aef61533b516fa2576a2c7fe7664:
>
> ?Linux 3.4-rc7 (2012-05-12 18:37:47 -0700)
>
> are available in the git repository at:
> ?git://github.com/hzhuang1/linux.git board-specific

Hmm. We already pulled a branch with that name before, but it doesn't
seem to contain the same contents as this one. That's OK, but it would
have been fine to just apply these two more patches on top of the
previous branch, and ask us to pull it again (sending the diffstat for
the delta between previous pull and now).

Or create a new branch with a different name for independent patches.
But in this case, a re-pull request would have been fine.

Anyway, I've pulled this in to next/boards (and pxa/boards2) now. Thanks.


-Olof
