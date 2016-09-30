From: hillf.zj@alibaba-inc.com (Hillf Danton)
Date: Fri, 30 Sep 2016 17:43:26 +0800
Subject: [PATCH v4 2/2] arm64 Kconfig: Select gigantic page
In-Reply-To: <1475227569-63446-3-git-send-email-xieyisheng1@huawei.com>
References: <1475227569-63446-1-git-send-email-xieyisheng1@huawei.com>
 <1475227569-63446-3-git-send-email-xieyisheng1@huawei.com>
Message-ID: <00d101d21aff$188a86c0$499f9440$@alibaba-inc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 30, 2016 5:26 PM Yisheng Xie wrote
> 
> Arm64 supports gigantic page after
> commit 084bd29810a5 ("ARM64: mm: HugeTLB support.")
> however, it can only be allocated at boottime and can't be freed.
> 
> This patch selects ARCH_HAS_GIGANTIC_PAGE to make gigantic pages
> can be allocated and freed at runtime for arch arm64.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com> 
