From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Sep 2015 12:00:37 +0100
Subject: [PATCH] arm64: dma-mapping: check whether cma area is
 initialized or not
In-Reply-To: <1441957787-5526-1-git-send-email-jszhang@marvell.com>
References: <1441957787-5526-1-git-send-email-jszhang@marvell.com>
Message-ID: <20150911110036.GC5771@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:49:47PM +0800, Jisheng Zhang wrote:
> If CMA is turned on and CMA size is set to zero, kernel should
> behave as if CMA was not enabled at compile time.
> Every dma allocation should check existence of cma area
> before requesting memory.
> 
> Arm has done this by commit e464ef16c4f0 ("arm: dma-mapping: add
> checking cma area initialized"), also do this for arm64.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Will should pick this up for 4.3.

Thanks.

-- 
Catalin
