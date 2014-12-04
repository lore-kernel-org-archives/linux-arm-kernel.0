From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 4 Dec 2014 12:07:01 -0800
Subject: [PATCH v2] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <CANMBJr5e_tc9P8g=kh5ARJ1ARnLG2RX2AKVbd2j-=4X8x1uARg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2014 at 11:27, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> Add DTS for the Hardkernel Odroid XU3. The name of the DTS file is kept the
> same as the vendors naming, which means it's prefixed with exynos5422
> instead of exynos5800 as the SoC name even though it includes the
> exyno5800 dtsi.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Tested-by: Tyler Baker <tyler.baker@linaro.org>

Tested this atop of next-20141204, both on exynos_defconfig and
multi_v7_defconfig. All configurations boot fine on my odroid-xu3
board.

Cheers,
Tyler
