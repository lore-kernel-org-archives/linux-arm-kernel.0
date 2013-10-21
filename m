From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 21 Oct 2013 15:50:42 +0200
Subject: [PATCH 1/2] spi/s3c64xx: Do not ignore return value of
 spi_master_resume/suspend
In-Reply-To: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
References: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <52653132.4090803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/13 15:42, Krzysztof Kozlowski wrote:
> During PM resume and suspend do not ignore the return value of
> spi_master_suspend() or spi_master_resume(). Instead pass it further.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
