From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 20:10:21 -0700
Subject: [GIT PULL 08/10] ARM: tegra: second round of cleanups
In-Reply-To: <1347653181-19936-8-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
 <1347653181-19936-8-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOesGMizASxKLK9tOaqQB8mHktqM5w1wsR9xeAtMbh_8VHNPvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 1:06 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> This branch mainly removes dead code following the removal of all board
> files. The removals depend on various changes in other branches, so they
> are all merged together and form the basis of this branch, as enumerated
> below.
>
> Finally, there are no remaining users of pinconf-tegra.h outside the
> pinctrl subsystem, so that header is incorporated into an existing file
> there. This reduces the number of headers in mach-tegra/include, and so
> helps move towards single zImage.
>
> This branch is based on tegra-for-3.7-cleanup, followed by a merge of
> tegra-for-3.7-board-removal, followed by a merge of
> tegra-for-3.7-common-clk, followed by a merge of:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv-for-v3.7

Pulled into next/cleanup2, it has grown a few modify/remove conflicts
by now (dma.c and common.c), but they're easy to deal with.


-Olof
