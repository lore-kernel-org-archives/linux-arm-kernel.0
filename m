From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 13:10:28 +0900
Subject: [PATCHv2 2/3] ARM: exynos_defconfig: Enable CONFIG_SENSORS_INA2XX
 for odroidxu3.
In-Reply-To: <1431489174-4479-3-git-send-email-linux.amoon@gmail.com>
References: <1431489174-4479-1-git-send-email-linux.amoon@gmail.com>
 <1431489174-4479-3-git-send-email-linux.amoon@gmail.com>
Message-ID: <5552CEB4.1050302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.05.2015 12:52, Anand Moon wrote:
> Odroidxu3 board support power monitor sensor.

1. s/Odroidxu3/Odroid XU3/ (or Odroid-XU3, just capitalize the symbol).
2. Remove the trailing stop (dot) from commit title.

With these changes you can add my tag:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
