From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 18 Jun 2016 23:31:23 +0900
Subject: [PATCH] clk: samsung: exynos5433: use clock_ignore_unused flag
 for SPI3 related clocks
In-Reply-To: <1466151362-2881-1-git-send-email-andi.shyti@samsung.com>
References: <1466151362-2881-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <CA+Ln22F9eskcpnFkrnVFc3dJqCJcJ5O-STfXC-8Om5MK-THwNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi, Jaehoon,

2016-06-17 17:16 GMT+09:00 Andi Shyti <andi.shyti@samsung.com>:
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> The SPI 3 bus uses two clocks, a bus clock and an input clock.
> Do not disable the clocks when unused in order to allow access to
> the SPI 3 device.

If unused, why would access to SPI 3 device needed?

Best regards,
Tomasz
