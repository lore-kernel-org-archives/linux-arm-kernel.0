From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 27 Nov 2014 14:04:29 +0530
Subject: [v3, 1/2] arm64: Create link to include/dt-bindings to enable C
 preprocessor use.
In-Reply-To: <1415727131-4572-2-git-send-email-Liviu.Dudau@arm.com>
References: <1415727131-4572-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <5476E215.5020405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On Tuesday 11 November 2014 11:02 PM, Liviu Dudau wrote:
> DT files used in the compilation phase can be preprocessed by the C
> preprocessor. This requires an include/dt-bindings directory to be
> present in the arch/arm64/boot/dts directory.
>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>

Same change already has been posted as part of adding Exynos7 SoC 
support, as Exynos7 patches have been accepted in Kukjin's tree, I think 
following patch [1] as part of Exynos7 series [2] can also be taken.

1: http://www.spinics.net/lists/devicetree/msg56552.html
2: http://www.spinics.net/lists/devicetree/msg56551.html

Thanks,
Pankaj Dubey

> ---
> arch/arm64/boot/dts/include/dt-bindings | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 120000 arch/arm64/boot/dts/include/dt-bindings
>
> \ No newline at end of file
>
> diff --git a/arch/arm64/boot/dts/include/dt-bindings b/arch/arm64/boot/dts/include/dt-bindings
> new file mode 120000
> index 0000000..08c00e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/include/dt-bindings
> @@ -0,0 +1 @@
> +../../../../../include/dt-bindings
>
