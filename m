From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 17 Oct 2013 14:48:07 +0200
Subject: [PATCH] spi: spi-s3c64xx: Add missing pm_runtime_put on setup fail
In-Reply-To: <1382013941-861-1-git-send-email-k.kozlowski@samsung.com>
References: <1382013941-861-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <525FDC87.1050402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/13 14:45, Krzysztof Kozlowski wrote:
> pm_runtime_put() wasn't called if clock rate could not be set up in
> s3c64xx_spi_setup() leading to invalid count of device pm_runtime usage.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
