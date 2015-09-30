From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 30 Sep 2015 15:55:24 +0900
Subject: [PATCH v2] ARM: dts: Add Exynos5250 Snow Rev5+ support
In-Reply-To: <1443595455-12754-1-git-send-email-javier@osg.samsung.com>
References: <1443595455-12754-1-git-send-email-javier@osg.samsung.com>
Message-ID: <560B875C.8080705@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/15 15:44, Javier Martinez Canillas wrote:
> There are 2 revisions of the Exynos5250 Snow Chromebook that were shipped:
> Rev4 and Rev5. The only difference between these 2 revisions is the codec,
> Rev4 has a max98095 codec while Rev5 has a max98090.
> 
> Mainline only supports Rev4 so this patch moves the common device nodes to
> a DTSI file and adds a DTS for the Exynos5250 Snow Rev5.
> 
> The Snow Rev5 DTS is based on the DTS found in the ChromiumOS 3.8 tree.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Tested-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ---
> 
> Changes in v2:
> - Add Mauro Carvalho Chehab's Tested-by tag.
> - Add Doug Anderson's Reviewed-by tag.
> - Remove warning about adding a whitespace error. Suggested by Doug Anderson.
> - Make Rev{4,5} codec pinctrl properties to match. Suggested by Doug Anderson.
> - Add "google,snow-rev4" to compatible string. Suggested by Krzysztof Kozlowski.
> 
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 684 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-snow-rev5.dts    |  47 ++
>  arch/arm/boot/dts/exynos5250-snow.dts         | 671 +------------------------
>  4 files changed, 736 insertions(+), 667 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos5250-snow-common.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos5250-snow-rev5.dts
> 
Applied, thanks.

- Kukjin
