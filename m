From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 17 Oct 2013 18:10:58 +0200
Subject: [PATCH] spi/s3c64xx: Add missing pm_runtime_set_active() call in
 probe()
In-Reply-To: <1382026006-15544-1-git-send-email-k.kozlowski@samsung.com>
References: <1382026006-15544-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <52600C12.3000606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/13 18:06, Krzysztof Kozlowski wrote:
> Mark device as PM runtime active during initialization to reflect
> actual device power/clocks state. This reduces the enable count for SPI
> bus controller gate clock so it can be disabled when the bus controller
> is not used.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
