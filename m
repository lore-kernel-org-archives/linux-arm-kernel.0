From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 24 Feb 2016 09:53:32 +0900
Subject: [PATCH] ARM: plat-samsung: remove unused register definitions
In-Reply-To: <1456218373-23658-1-git-send-email-pankaj.dubey@samsung.com>
References: <1456218373-23658-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56CCFF0C.3000004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.02.2016 18:06, Pankaj Dubey wrote:
> This patch removes S5P_VA_TWD and S3C_UART_OFFSET as it is no more used
> by any platform which including this header file.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/plat-samsung/include/plat/map-s5p.h | 5 -----
>  1 file changed, 5 deletions(-)

Just squash it with previous patch and remove S3C_UART_OFFSET
atomically. Everywhere or nowhere. Not a little bit here, a little bit
there.

Best regards,
Krzysztof
