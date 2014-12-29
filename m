From: nm@ti.com (Nishanth Menon)
Date: Mon, 29 Dec 2014 08:29:58 -0600
Subject: [PATCH v10 2/8] ARM: l2c: Refactor the driver to use commit-like
 interface
In-Reply-To: <549FEABA.10206@gmail.com>
References: <1419331716-8972-1-git-send-email-m.szyprowski@samsung.com>
 <1419331716-8972-3-git-send-email-m.szyprowski@samsung.com>
 <20141223170613.GM23854@atomide.com> <5499A2B4.2080909@ti.com>
 <549FEABA.10206@gmail.com>
Message-ID: <20141229142958.GA10746@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:34-20141228, Tomasz Figa wrote:
> May I ask you (or anyone else working on OMAP) to try to figure out
> what the issue is? It is stopping L2 cache support for Exynos4 being

http://slexy.org/view/s2BnzxVglj
Took a register dump and compared -> Got the same dump
http://slexy.org/view/s21YRHpzeW .

Basically, this implies: possible sequence change broke AM437x or
some secure function call (which i have'nt dumped).

Is it possible to break up this patch into easier patches?

-- 
Regards,
Nishanth Menon
