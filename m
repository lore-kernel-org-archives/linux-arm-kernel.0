From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 16 Apr 2018 20:20:44 +0200
Subject: [PATCH 1/3] arm: dts: exynos: Add serial path for Rinato board
 to get earlycon support
In-Reply-To: <20180416103537.29518-1-m.szyprowski@samsung.com>
References: <CGME20180416103544eucas1p2c393cdccdb79955b64e57ccc53456479@eucas1p2.samsung.com>
 <20180416103537.29518-1-m.szyprowski@samsung.com>
Message-ID: <20180416182044.wa6rujh27jjzu3kv@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 12:35:35PM +0200, Marek Szyprowski wrote:
> Add 'chosen' node with 'stdout-path' property to instruct kernel which
> serial driver should be used for kernel console/logs. This allows to
> enable earlycon messages by adding just 'earlycon' parameter to kernel
> command line.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-rinato.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
