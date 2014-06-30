From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Jun 2014 15:49:58 +0200
Subject: [PATCH 1/2] clk: samsung: fix several typos to fix boot on s3c2410
In-Reply-To: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
References: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
Message-ID: <53B16B06.6070206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.06.2014 22:29, Vasily Khoruzhick wrote:
> There's a several typos in a driver: 2410 instead of S3C2410
> and wrong argument to ARRAY_SIZE(). They prevent s3c2410
> from properly booting.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/clk/samsung/clk-s3c2410.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied as a fix for 3.16.

Best regards,
Tomasz
