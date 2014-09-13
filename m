From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 14 Sep 2014 02:22:54 +0900
Subject: [PATCH V3 1/2] ARM: dts: Add DT changes for display on snow
In-Reply-To: <1409567792-8281-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1409567792-8281-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <54147D6E.2030103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/14 19:36, Ajay Kumar wrote:
> Add DT nodes for ptn3460 bridge chip and panel.
> Add backlight enable pin and backlight power supply for pwm-backlight.
> Also add bridge phandle needed by dp to enable display on snow.
>
> Signed-off-by: Ajay Kumar<ajaykumar.rs@samsung.com>
> ---
> Changes since V1:
> 	-- Remove "simple-panel" compatible string.
> 	-- Use GPIO_ACTIVE_HIGH instead of 0.
> 	-- Change panel node naming from "panel-simple" to "panel".
>
> Changes since V2:
> 	-- Use proper compatible string: "auo,b116xw03"
>
>   arch/arm/boot/dts/exynos5250-snow.dts |   41 ++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 19 deletions(-)
>
Applied this and 2nd one.

BTW, I resolved conflict when I applied. Please check my tree and then 
if any problems, please let me know.

Thanks,
Kukjin
