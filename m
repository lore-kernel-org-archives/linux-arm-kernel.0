From: mmayer@broadcom.com (Markus Mayer)
Date: Mon, 24 Sep 2012 15:48:04 -0700
Subject: [PATCH 0/1] Fix segfault in DTC
Message-ID: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please let me know if there is a different place this patch should be sent
to. Thanks.

Markus Mayer (1):
  Fix segfault in dtc when empty input file is given.

 scripts/dtc/treesource.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.5.4
