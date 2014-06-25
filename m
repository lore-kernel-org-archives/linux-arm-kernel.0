From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 25 Jun 2014 13:26:13 +0200
Subject: [PATCH 1/2] clk: samsung: fix several typos to fix boot on s3c2410
In-Reply-To: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
References: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
Message-ID: <53AAB1D5.1090404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasily,

On 23.06.2014 22:29, Vasily Khoruzhick wrote:
> There's a several typos in a driver: 2410 instead of S3C2410
> and wrong argument to ARRAY_SIZE(). They prevent s3c2410
> from properly booting.

Thanks for fixing this. I will apply and send to Mike with other fixes.
Same for patch 2/2.

Best regards,
Tomasz
