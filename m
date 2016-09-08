From: n-horiguchi@ah.jp.nec.com (Naoya Horiguchi)
Date: Thu, 8 Sep 2016 09:55:05 +0000
Subject: [RFC PATCH v3 1/2] mm/hugetlb: Introduce ARCH_HAS_GIGANTIC_PAGE
In-Reply-To: <1471872004-59365-2-git-send-email-xieyisheng1@huawei.com>
References: <1471872004-59365-1-git-send-email-xieyisheng1@huawei.com>
 <1471872004-59365-2-git-send-email-xieyisheng1@huawei.com>
Message-ID: <20160908095504.GA2554@hori1.linux.bs1.fc.nec.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 09:20:03PM +0800, Xie Yisheng wrote:
> Avoid making ifdef get pretty unwieldy if many ARCHs support gigantic page.
> No functional change with this patch.
> 
> Signed-off-by: Xie Yisheng <xieyisheng1@huawei.com>

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
