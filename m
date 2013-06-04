From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 14:23:21 +0200
Subject: [GIT PULL 2/5]: ux500 clocksource changes for v3.11
Message-ID: <CACRpkdbPBvEU0V29YCqL6Tp0XGbjfJebrZu1TZ_4OFkjB9dMww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this is the ux500 clocksource changes for v3.11. See the signed
tag for details.

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-clksrc-for-arm-soc

for you to fetch changes up to 807eba55f73e98b76d0afdc197d942c46122bdca:

  clocksource: dbx500-prcmu: comment cleanup (2013-05-27 14:05:54 +0200)

----------------------------------------------------------------
Ux500 clocksource updates:
- Use relaxed readl() variant
- Fix a single comment

----------------------------------------------------------------
Fabio Baltieri (1):
      clocksource: dbx500-prcmu: comment cleanup

Rabin Vincent (1):
      clocksource: dbx500-prcmu: use relaxed readl variant

 drivers/clocksource/clksrc-dbx500-prcmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)
