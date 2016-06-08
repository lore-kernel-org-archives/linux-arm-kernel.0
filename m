From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 08 Jun 2016 09:35:05 +0200
Subject: [PATCH] of: reserved_mem: restore old behavior when no region is
 defined
In-Reply-To: <1465368713-17866-1-git-send-email-m.szyprowski@samsung.com>
References: <20160607143425.GE1165@e106497-lin.cambridge.arm.com>
 <1465368713-17866-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5757CAA9.6000001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2016 08:51 AM, Marek Szyprowski wrote:
> Change return value back to -ENODEV when no region is defined for given
> device. This restores old behavior of this function, as some drivers rely
> on such error code.
> 
> Reported-by: Liviu Dudau <liviu.dudau@arm.com>
> Fixes: 59ce4039727ef40 ("of: reserved_mem: add support for using more than
>        one region for given device")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I think this needs to be added to the media tree, where the original
patch it fixes was applied.

-- 
Thanks,
Sylwester
