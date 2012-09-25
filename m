From: mmayer@broadcom.com (Markus Mayer)
Date: Tue, 25 Sep 2012 10:58:08 -0700
Subject: [PATCH 0/1] Fix segfault in DTC
In-Reply-To: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
References: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
Message-ID: <1348595889-6495-1-git-send-email-mmayer@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested on linux-arm-kernel, I am copying devicetree-discuss, as well
as David and Jon on this thread. Please let me know your thoughts.

Regards,
-Markus

Markus Mayer (1):
  Fix segfault in dtc when empty input file is given.

 scripts/dtc/treesource.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.5.4
