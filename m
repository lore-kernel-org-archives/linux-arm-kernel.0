From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Tue, 15 Mar 2011 22:07:00 +0900
Subject: [PATCH v2] ARM: EXYNOS4: add a placeholder for board specific
	interrupts
In-Reply-To: <011301cbe310$41381f10$c3a85d30$%kim@samsung.com>
References: <1300086405-9895-1-git-send-email-m.szyprowski@samsung.com>
	<011301cbe310$41381f10$c3a85d30$%kim@samsung.com>
Message-ID: <AANLkTim0Ld63n5raA0107yq_eQXY4__acd7rx7CaQOjo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now pmic8998, 8997 requires extra interrupts.

If you don't want to extends irqs, the sparse irq can be used at each board.

Of course, in case of exynos4210, need some patch for sparse irq support.

Kyungmin Park
