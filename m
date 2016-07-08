From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 8 Jul 2016 22:33:28 +0200
Subject: [PATCH v2 4/7] spi: s3c64xx: use error code from
 clk_prepare_enable()
In-Reply-To: <1467989201-14661-5-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-5-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160708203328.GC25980@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 11:46:38PM +0900, Andi Shyti wrote:
> If clk_prepare_enable() fails do not return -EBUSY but use the
> value provided by the function itself.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Cool, thanks for fixing existing pattern:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
