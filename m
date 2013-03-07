From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 07 Mar 2013 12:24:32 +0100
Subject: [PATCH] ARM: EXYNOS: remove EXYNOS_DEV_SYSMMU entirely
In-Reply-To: <014f01ce1ad0$e4432b10$acc98130$%kim@samsung.com>
References: <1362509466.16460.108.camel@x61.thuisdomein>
 <014f01ce1ad0$e4432b10$acc98130$%kim@samsung.com>
Message-ID: <1362655472.5994.2.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-07 at 10:12 +0900, Kukjin Kim wrote:
> Actually, to update iommu for exynos is on-going. And as I know, it
> will be done this time for v3.10 by KyongHo Cho, so it would be better
> to handle this cleanup with that at the same time.

You mean I should try to recheck the status of EXYNOS_DEV_SYSMMU around
(say) v3.10-rc1? If so, that's fine with me.


Paul Bolle
