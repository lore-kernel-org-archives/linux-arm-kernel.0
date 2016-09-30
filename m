From: hillf.zj@alibaba-inc.com (Hillf Danton)
Date: Fri, 30 Sep 2016 17:41:52 +0800
Subject: [PATCH v4 1/2] mm/hugetlb: Introduce ARCH_HAS_GIGANTIC_PAGE
In-Reply-To: <1475227569-63446-2-git-send-email-xieyisheng1@huawei.com>
References: <1475227569-63446-1-git-send-email-xieyisheng1@huawei.com>
 <1475227569-63446-2-git-send-email-xieyisheng1@huawei.com>
Message-ID: <00d001d21afe$e08df220$a1a9d660$@alibaba-inc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 30, 2016 5:26 PM Yisheng Xie
> 
> Avoid making ifdef get pretty unwieldy if many ARCHs support gigantic page.
> No functional change with this patch.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com>
