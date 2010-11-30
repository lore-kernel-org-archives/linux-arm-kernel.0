From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Nov 2010 10:31:43 +0100
Subject: Please include ux500 core into linux-next
Message-ID: <AANLkTi=fXAucNc-m9dqb0cgA6mGJ5c4cXC-pTOz05vwY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

please consider to start merging our ux500-core branch into
linux-next:

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
Branch: ux500-core

(NB: there is a "next" branch, which include patches to multiple
subsystems, don't merge that, this is just the ux500 core.)

I rebase this regularly to Torvalds' -rc tags, hope that's OK.

All code is being reviewed on the linux-arm-kernel list, and the
patches here are intended for pull request to Russell King who
in turn take them upstream. I hope this procedure is
acceptable.

We currently have some of these patches in Russells patch tracker
as well, but they will be taken out in favor of the pull approach
once this branch lands in -next.

Yours,
Linus Walleij
