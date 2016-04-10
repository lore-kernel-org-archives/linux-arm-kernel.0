From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 10 Apr 2016 10:14:26 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable CPUFreq governors as
 modules
In-Reply-To: <1460142130-31822-2-git-send-email-javier@osg.samsung.com>
References: <1460142130-31822-1-git-send-email-javier@osg.samsung.com>
 <1460142130-31822-2-git-send-email-javier@osg.samsung.com>
Message-ID: <20160410081426.GA9519@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 03:02:10PM -0400, Javier Martinez Canillas wrote:
> Currently only the ondemand and performance CPUFreq policy governors are
> enabled in multi_v7 defconfig. But the other governors are also useful
> for some cases, enable them to allow users change the default if needed.
> 
> The options are enabled as module to keep the kernel image size minimal.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)

Hi,

Makes sense for me. If there are no objections I can take it through
samsung-soc tree along with exynos_defconfig change.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
