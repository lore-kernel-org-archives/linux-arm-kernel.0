From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 14 Apr 2017 14:59:50 +0200
Subject: [PATCH v7 5/9] MAINTAINERS: add maintainers for DRM STM driver
In-Reply-To: <1492164819-10513-6-git-send-email-yannick.fertre@st.com>
References: <1492164819-10513-1-git-send-email-yannick.fertre@st.com>
 <1492164819-10513-6-git-send-email-yannick.fertre@st.com>
Message-ID: <b86376fd-1f73-7cec-8f4b-9a4cb4dd3f15@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2017 12:13 PM, Yannick Fertre wrote:
> Add Philippe Cornu and myself as maintainers.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c36dfae..84cf73f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4424,6 +4424,15 @@ S:	Maintained
>  F:	drivers/gpu/drm/sti
>  F:	Documentation/devicetree/bindings/display/st,stih4xx.txt
>  
> +DRM DRIVERS FOR STM
> +M:	Yannick Fertre <yannick.fertre@st.com>
> +M:	Philippe Cornu <philippe.cornu@st.com>
> +L:	dri-devel at lists.freedesktop.org
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +S:	Maintained
> +F:	drivers/gpu/drm/stm
> +F:	Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> +
>  DRM DRIVER FOR TDFX VIDEO CARDS
>  S:	Orphan / Obsolete
>  F:	drivers/gpu/drm/tdfx/
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
