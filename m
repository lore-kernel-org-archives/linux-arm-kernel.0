From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Dec 2015 10:14:02 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable fan,
 sensors and audio for Odroid XU3
In-Reply-To: <1449449994-10110-1-git-send-email-k.kozlowski@samsung.com>
References: <1449449994-10110-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <3286190.bAhobgE2la@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 09:59:54 Krzysztof Kozlowski wrote:
> For Odroid XU3-family enable the:
>  - PWM fan (to control the CPU fan using thermal subsystem),
>  - TI INA231 sensors (provide power measurements of big.LITTLE cores,
>    DRAM and GPU),
>  - Samsung sound (for Odroid XU3 and Snow as well).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Looks good. Do you have a samsung/defconfig branch already that you
can put this into, or should be pick it up into arm-soc directly?

My preference is the former, but it would be a bit silly if that
is the only samsung defconfig change we need.

	Arnd
