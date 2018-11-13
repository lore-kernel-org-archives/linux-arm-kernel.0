From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 13 Nov 2018 20:54:56 +0100
Subject: [PATCHv5 4/6] ARM: dts: exynos: Add pin configuration for SD
 write protect on Odroid XU3/XU4
In-Reply-To: <20180927140738.1006-5-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-5-linux.amoon@gmail.com>
Message-ID: <20181113195456.GF2418@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 02:07:36PM +0000, Anand Moon wrote:
> Add SD card write-protect pin configuration to be sure that it will be
> properly pulled down to indicate write access.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes since v4:
> 1. Remove cd-gpios and wp-gpios leaving only WP pin configuration (after
>    Marek Szyprowski feedback).
> 2. Pull pin down.
> 3. change the subject and commit message.
> Sorry Krzysztof if I have copied your commit message to describe the
> changes.

Thanks, applied.

Best regards,
Krzysztof
