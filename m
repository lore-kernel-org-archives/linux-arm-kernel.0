From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 18 Sep 2017 19:06:20 +0200
Subject: [RESEND PATCH v4 3/3] ARM: dts: exynos: Remove the
 display-timing and delay from rinato dts
In-Reply-To: <1505703264-6704-1-git-send-email-hoegeun.kwon@samsung.com>
References: <CGME20170918025448epcas2p22a44b6c8efeac613e7e90c3c49b3eb8a@epcas2p2.samsung.com>
 <1505703264-6704-1-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170918170620.zwxjxqnvnudw6m47@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 11:54:24AM +0900, Hoegeun Kwon wrote:
>  The display-timing and delay are included in the panel driver. So it
>  should be removed in dts.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
> 
> Hi Krzysztof,
> 
> This patch was rebased to the mainline (v4.14-rc1).
> 
> Best regards,
> Hoegeun
> 
>  arch/arm/boot/dts/exynos3250-rinato.dts | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
