From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Feb 2013 14:54:49 -0800
Subject: [GIT PULL 0/3] arm-soc: late changes for 3.9
Message-ID: <1362092093-4839-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is a series of merge requests for arm-soc branches.

The first two are mostly normal changes, The OMAP changes came in late
before the merge window opened, so we wanted to let them sit for a few
more days in -next. The i.MX branch is a churny branch that I wanted to
keep separate and not have other code depend on, and thus held it off
to the second batch.

Final two pull requests are for the same code. As Arnd describes in the
tags, they are for a set of mvebu patches that depend on contents in
the MMC tree. We had pulled in part of the MMC branch as a dependency,
but unfortunately Chris Ball rebased it.

We're giving you the choice of taking the rebased version, or a
non-rebased-but-merged-and-fixed-up version to avoid dealing with the
excessive conflicts. The rebased one has the obvious benefit of not
having duplicate commits in the tree for the same changes, but, well,
it's rebased. Actual tree contents is identical though.

I've pushed a resolved branch for reference (late-branches-resolved)
in case you want to compare conflict resolutions.


Thanks,

-Olof
