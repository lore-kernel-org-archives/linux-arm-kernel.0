From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 2 Jun 2016 14:03:06 +0800
Subject: [PATCH 0/3] of: numa: cleanup
In-Reply-To: <1464834491-12024-1-git-send-email-thunder.leizhen@huawei.com>
References: <1464834491-12024-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1464847389-11652-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1) Use of_get_next_parent in of_node_to_nid.
2) Use pr_fmt to prefix kernel output. and drop duplicated message
   of NUMA turned off.

Based of Zhen Lei 's patchset v3 "fix some type infos and bugs for arm64/of num"
in http://www.spinics.net/lists/arm-kernel/msg507650.html.

Kefeng Wang (3):
  of_numa: Use of_get_next_parent to simplify code
  of_numa: Use pr_fmt()
  arm64: numa: Use pr_fmt()

 arch/arm64/mm/numa.c | 42 +++++++++++++++++++++---------------------
 drivers/of/of_numa.c | 25 +++++++++++--------------
 2 files changed, 32 insertions(+), 35 deletions(-)

-- 
1.7.12.4
