From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 7 Mar 2014 15:27:57 +0100
Subject: [PATCH v9][ 6/8] staging: imx-drm: parallel display: add
 regulator support.
In-Reply-To: <1394121869-13387-3-git-send-email-denis@eukrea.com>
References: <1394121702-13257-3-git-send-email-denis@eukrea.com>
 <1394121869-13387-1-git-send-email-denis@eukrea.com>
 <1394121869-13387-3-git-send-email-denis@eukrea.com>
Message-ID: <20140307152757.6e97abce@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v8->v9:
> - Removed the Cc. They are now set in git-send-email directly.
> - Rebased.
> 
> ChangeLog v7->v8:
> - Shrinked even more the Cc list.
> - Rebased.
> 
> ChangeLog v6->v7:
> - Shrinked even more the Cc list.
> - Rebased the patch and included video/of_display_timing.h
> ---
>  .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    1 +
>  drivers/staging/imx-drm/parallel-display.c         |   13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> index 2d24425..4dd7ce5 100644
> --- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> +++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> @@ -28,6 +28,7 @@ Required properties:
>  - compatible: Should be "fsl,imx-parallel-display"
>  - crtc: the crtc this display is connected to, see below
>  Optional properties:
> +- display-supply : phandle to the regulator device tree node if needed.
>
Any reason why this is named 'display-supply' rather than 'lcd-supply'
like for imxfb?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
