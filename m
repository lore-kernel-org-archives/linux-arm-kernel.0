From: apinski@cavium.com (Andrew Pinski)
Date: Sun, 13 Mar 2016 12:50:18 -0700
Subject: [PATCH 0/2] *** SUBJECT HERE ***
Message-ID: <1457898620-1867-1-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*** BLURB HERE ***

Andrew Pinski (2):
  ARM64:VDSO: Improve gettimeofday, don't use udiv
  ARM64:VDSO: Improve __do_get_tspec, don't use udiv

 arch/arm64/kernel/vdso/gettimeofday.S |   47 ++++++++++++++++++++++++--------
 1 files changed, 35 insertions(+), 12 deletions(-)

-- 
1.7.2.5
