From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Nov 2015 09:12:22 +0900
Subject: [PATCH v6 4/4] ARM: dts: Add Ethernet chip to SMDK5410
In-Reply-To: <27f540c1990df410bc20dcac7a35bede19fdb45b.1446724046.git.p.fedin@samsung.com>
References: <cover.1446724046.git.p.fedin@samsung.com>
 <27f540c1990df410bc20dcac7a35bede19fdb45b.1446724046.git.p.fedin@samsung.com>
Message-ID: <563BF066.1040108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 21:03, Pavel Fedin wrote:
> The chip is smsc9115, connected via SROMc bank 3. Additionally, some GPIO
> initialization is required.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5410-smdk5410.dts | 41 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi         |  6 +++++
>  2 files changed, 47 insertions(+)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
