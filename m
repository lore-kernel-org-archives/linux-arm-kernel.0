From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 28 Oct 2015 12:02:11 +0300
Subject: [GIT PULL 4/5] Late Samsung driver updates for v4.4
In-Reply-To: <563081DE.9010500@samsung.com>
References: <562AA40E.4050407@kernel.org> <562AA603.7040600@kernel.org>
 <56307B33.90608@samsung.com> <000101d11155$1f8d6eb0$5ea84c10$@samsung.com>
 <56307FEA.6090207@samsung.com> <000801d11156$c0e0c270$42a24750$@samsung.com>
 <563081DE.9010500@samsung.com>
Message-ID: <001d01d1115f$556b3670$0041a350$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> The noticeable change between v4.1 and v4.2 was for example:
> c4241a582d22 ("ARM: EXYNOS: use PS_HOLD based poweroff for all supported
> SoCs")

 First of all, sorry for misinforming you. It was not v4.1 which worked, but 3.18 one. I never ran 4.1 on this board, it's my
memory's fault...
 Second, the commit which actually broke 5410 is 8cfc7fdd33080e30b86d21b1a8c9ad0686427ddc ("ARM: EXYNOS: move restart code into pmu
driver"). And we don't have 5410 PMU description in our DT, that's the problem.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
