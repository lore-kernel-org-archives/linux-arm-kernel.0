From: olof@lixom.net (Olof Johansson)
Date: Thu, 7 Jan 2016 06:16:14 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable fan, sensors and audio
 for Odroid XU3
In-Reply-To: <1450867037-19705-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1450867037-19705-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20160107051614.GE26875@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 07:37:17PM +0900, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> For Odroid XU3-family enable the:
>  - PWM fan (to control the CPU fan using thermal subsystem),
>  - TI INA231 sensors (provide power measurements of big.LITTLE cores,
>    DRAM and GPU),
>  - Samsung sound (for Odroid XU3 and Snow as well).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Resending with Javier's tag.

Thanks, applied but had to resolve conflicts.


-Olof
