From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Feb 2016 13:41:48 +0000
Subject: [PATCH v2 0/7] irqchip: introduce the Alpine MSIX driver
In-Reply-To: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <56BC8F9C.3060505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine,

On 10/02/16 13:22, Antoine Tenart wrote:
> Hi all,
> 
> This series introduce the Alpine MSIX driver, and enables it in both
> the Alpine v1 and Alpine v2 device trees.
> 
> This series depends on "[PATCH v2 0/3] arm64: introduce the Alpine support":
> https://lkml.org/lkml/2016/2/10/83
> 
> You can find the series at:
> https://github.com/atenart/linux.git 4.5-rc1/alpinev2-msix

So I'm quite happy with this as it is (modulo the documentation fix on
patch 3). I can take the first 3 patches through my GIC tree, but the
last 4 patches depend on your other series.

Would it be a problem to get these 4 patches merged after 4.6-rc1, so
that all the code can be merged before?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
