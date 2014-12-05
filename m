From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  5 Dec 2014 12:34:53 +0000
Subject: [PATCH 0/2] arm64: mm: dump: a couple of fixes
Message-ID: <1417782895-13657-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While using the mm dump code, I spotted a couple of issues; one build warning
and one theoretical failure on systems endowed with plenty of RAM (as with ARM
[1], though arm64 requires a slightly different resolution). These patches
(based on next-20141205), fix those issues.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308952.html

Mark Rutland (2):
  arm64: mm: dump: fix shift warning
  arm64: mm: dump: don't skip final region

 arch/arm64/mm/dump.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
1.9.1
