From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 28 Oct 2015 11:00:45 +0300
Subject: [GIT PULL 4/5] Late Samsung driver updates for v4.4
In-Reply-To: <56307FEA.6090207@samsung.com>
References: <562AA40E.4050407@kernel.org> <562AA603.7040600@kernel.org>
 <56307B33.90608@samsung.com> <000101d11155$1f8d6eb0$5ea84c10$@samsung.com>
 <56307FEA.6090207@samsung.com>
Message-ID: <000801d11156$c0e0c270$42a24750$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> The Exynos5410 in current form does not have suspend capability. During
> boot you should see in dmesg:
> 	Failed to find PMU node
> coming from mach-exynos/suspend.c.

 Indeed. By the way, can this be a reason why reboot stopped working? It worked in v4.1. Isn't this a regression?
 Ok, nevertheless, here is v3 of my patchset.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
