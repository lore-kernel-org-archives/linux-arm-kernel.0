From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 9 Apr 2015 09:10:58 +0200
Subject: [PATCH RFC v9 09/20] drm/dsi: Add a helper to get bits per pixel
 of MIPI DSI pixel format
In-Reply-To: <1423720903-24806-10-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-10-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20150409071057.GA12103@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 02:01:32PM +0800, Liu Ying wrote:
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
> v8->v9:
>  * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.
> 
> v7->v8:
>  * None.
> 
> v6->v7:
>  * None.
> 
> v5->v6:
>  * Address the over 80 characters in one line warning reported by the
>    checkpatch.pl script.
> 
> v4->v5:
>  * None.
> 
> v3->v4:
>  * None.
> 
> v2->v3:
>  * None.
> 
> v1->v2:
>  * Thierry Reding suggested that the mipi_dsi_pixel_format_to_bpp() function
>    could be placed at the common DRM MIPI DSI driver.
>    This patch is newly added.
> 
>  include/drm/drm_mipi_dsi.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/547f26a9/attachment.sig>
