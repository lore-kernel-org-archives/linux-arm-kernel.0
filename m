From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Aug 2012 10:44:46 -0700
Subject: [GIT PULL 0/3] ARM: late-arrived arm-soc branches for 3.6
Message-ID: <CAOesGMgJjJd=69AgNZFSOWvEqjRO3=SspY5rUQxwVnWr5fe2uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following 3 pull requests (well, the latter two) are for branches
that showed up late for this merge window but we staged anwyay, on a
best-effort basis.

2/3 is for grouped cpuidle updates on OMAP which missed 3.5 due to the
infrastructure not going in. Since it's well-contained to their
platform, and they are eager to see it go in, I picked it up and let
it sit in -next for about a week and I think it's good to go by now.

3/3 is device-tree updates for Marvell Orion. The maintainers and
developers on these platforms are mostly hobbyists so we're trying to
help them get used to the workflow, etc, and in this case it meant
they needed a little while to get the branches sorted out. The code is
reasonably well-contained and again has sat in linux-next for almost a
week.


That being said, we are flexing the rules a bit here and if you're
less than excited to pick these up at this time, let us know and we
can hold them until the 3.7 window instead.

Please do merge the first branch of fixes though.


Thanks!

-Olof
