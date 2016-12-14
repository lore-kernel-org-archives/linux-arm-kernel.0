From: zhongjiang@huawei.com (zhongjiang)
Date: Wed, 14 Dec 2016 22:19:09 +0800
Subject: [RESEND PATCH 0/2] fix some trivial bug involving the contiguous bit
Message-ID: <1481725151-20549-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhong jiang <zhongjiang@huawei.com>

Hi,
    The following patch have sent it last week, but it fails to receive any reply.
These patch is simple but reasonable. I hope it can merge to next version. So, 
if anyone has any objection, just please let me know. 

Thanks
zhongjiang 

zhong jiang (2):
  arm64: change from CONT_PMD_SHIFT to CONT_PTE_SHIFT
  arm64: make WANT_HUGE_PMD_SHARE depends on HUGETLB_PAGE

 arch/arm64/Kconfig          | 1 +
 arch/arm64/mm/hugetlbpage.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.3.1
