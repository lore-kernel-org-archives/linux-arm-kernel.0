From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 24 Nov 2014 18:28:48 +0100
Subject: [RFC 0/2] Fix Arndale Octa/Peach Pi boot on Audio subsystem clocks
In-Reply-To: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
References: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54736AD0.4070909@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 11/24/2014 04:18 PM, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> This is initial idea to solve dependency between AudioSS clocks
> and main clock controller on Exynos platform.
> 
> This solves boot failure of Peach Pi/Pit and Arndale Octa [1].
> 

I tested this series on an Exynos5420 Peach Pit but I still
have the boot hang so it doesn't solve the issue on this board.

I'm using linux-next + your patches with exynos_defconfig and
without the clk_ignore_unused command line parameter.

Best regards,
Javier
