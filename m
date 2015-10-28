From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 28 Oct 2015 10:49:05 +0300
Subject: [GIT PULL 4/5] Late Samsung driver updates for v4.4
In-Reply-To: <56307B33.90608@samsung.com>
References: <562AA40E.4050407@kernel.org> <562AA603.7040600@kernel.org>
 <56307B33.90608@samsung.com>
Message-ID: <000101d11155$1f8d6eb0$5ea84c10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> The question is - do you prefer us to send a following up patch or to
> fix it by amending the commit?
> 
> Here is a fix which can be squashed into these two commits:

 By the way, since we are discussing fixing these commits...
 After hardcoded SROMc handling has been removed, Exynos5410-based machines stopped handling it entirely, because the description
has never been added to exynos5410.dtsi (which does not include exynos5.dtsi). Shouldn't the description be added there too?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
