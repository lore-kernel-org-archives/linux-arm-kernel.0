From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 12 Feb 2018 19:49:47 +0100
Subject: [PATCH v3] ARM: dts: exynos-artik5: add support for wlan
In-Reply-To: <20180201211656.11829-1-mlyle@lyle.org>
References: <20180201211656.11829-1-mlyle@lyle.org>
Message-ID: <20180212184947.zeloekwy4o4yih7u@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 01:16:56PM -0800, Michael Lyle wrote:
> On the Artik520 module, there's a bcm4354 attached to mshc_1.  Enable
> it, and turn on the regulator used for it, so that both wifi & bluetooth
> work.
> 
> Verified to work on the Artik 520 evaluation board.
> 
> v2: accidentally sent out v1
> v3: non-removable instead of broken-cd, alphabetical order, formatting
> 
> Signed-off-by: Michael Lyle <mlyle@lyle.org>
> ---
>  arch/arm/boot/dts/exynos3250-artik5.dtsi | 36 ++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
