From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Jun 2014 15:50:11 +0200
Subject: [PATCH 2/2] clk: samsung: add more aliases for s3c24xx
In-Reply-To: <1403555350-14895-2-git-send-email-anarsoul@gmail.com>
References: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
 <1403555350-14895-2-git-send-email-anarsoul@gmail.com>
Message-ID: <53B16B13.5070602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.06.2014 22:29, Vasily Khoruzhick wrote:
> Without these aliases clock lookup fails in s3c2410fb,
> s3cmci, s3c2410-nand, s3c24xx-i2s, and i2c-s3c2410 drivers.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/clk/samsung/clk-s3c2410.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied as a fix for 3.16.

Best regards,
Tomasz
