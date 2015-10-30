From: huawei.libin@huawei.com (Li Bin)
Date: Fri, 30 Oct 2015 16:31:01 +0800
Subject: [PATCH 0/3] recordmcount: bugfix and amend
Message-ID: <1446193864-24593-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Li Bin (3):
  recordmcount: fix endianness handling bug for nop_mcount
  recordmcount: x86: assign a meaningful value to rel_type_nop
  recordmcount: arm64: replace the ignored mcount call into nop

 scripts/recordmcount.c | 26 +++++++++++++++++++++++++-
 scripts/recordmcount.h |  5 +++--
 2 files changed, 28 insertions(+), 3 deletions(-)

-- 
1.7.12.4
