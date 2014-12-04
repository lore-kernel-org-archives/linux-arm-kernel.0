From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 04 Dec 2014 13:47:11 -0800
Subject: [PATCH v2] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>
 (Sjoerd Simons's message of "Thu, 4 Dec 2014 20:27:49 +0100")
References: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <7hoarjw0io.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sjoerd Simons <sjoerd.simons@collabora.co.uk> writes:

> Add DTS for the Hardkernel Odroid XU3. The name of the DTS file is kept the
> same as the vendors naming, which means it's prefixed with exynos5422
> instead of exynos5800 as the SoC name even though it includes the
> exyno5800 dtsi.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
> Changes since v1:
>   * Add chosen/linux,stdout-path to point the serial console device
>   * Change memory start offset to 0x40000000 to match the vendors DTS (pointed
>     out by Heesub Shin)
>   * Declare base address & size for the memory banks to be used by the MFC
>
> Kevin, Tyler, even though the changes are small i didn't want to just stick
> your Tested-By on. Could you both be so kind to retest this on your XU3's ?

Tested-by: Kevin Hilman <khilman@linaro.org>

Tested on top of linux-next(ish) and Javier's dp-integ branch and it's
booting fine including HDMI display output.

Kevin
