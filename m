From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 15 May 2017 18:55:53 +0200
Subject: [PATCH] arm64: dts: exynos: Remove the te-gpios property in the
 TM2 boards
In-Reply-To: <1493085261-3488-1-git-send-email-hoegeun.kwon@samsung.com>
References: <CGME20170425015437epcas5p43549d47e69519f43d89ba2de496ba451@epcas5p4.samsung.com>
 <1493085261-3488-1-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170515165553.dytsj4w6hlevkluu@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 10:54:21AM +0900, Hoegeun Kwon wrote:
> The decon uses HW-TRIGGER, so TE interrupt is not necessary.
> Therefore, remove the te-gpios property in the TM2 dts.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 1 -
>  1 file changed, 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof
