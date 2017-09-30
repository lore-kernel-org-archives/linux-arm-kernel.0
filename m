From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 30 Sep 2017 18:40:37 +0200
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable USB3503 driver
In-Reply-To: <20170928202703.21364-1-linus.luessing@c0d3.blue>
References: <20170928202703.21364-1-linus.luessing@c0d3.blue>
Message-ID: <20170930164037.ccwzqzagymy3g37c@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 10:27:03PM +0200, Linus L?ssing wrote:
> The Odroid U3 (Exynos 4412 based) for instance needs this driver,
> otherwise its USB hub will not come up.
> 
> Also selecting it as built-in to allow booting from USB without
> an initrd/initramfs. exynos_defconfig does the same already, too.
> 
> Signed-off-by: Linus L?ssing <linus.luessing@c0d3.blue>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks, applied.

Best regards,
Krzysztof
