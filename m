From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 24 Sep 2018 21:07:33 +0200
Subject: [PATCH v2 6/7] drm: meson: use xxxsetbits32
In-Reply-To: <1537815856-31728-7-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-7-git-send-email-clabbe@baylibre.com>
Message-ID: <9925d909-5f50-499d-744d-f59170e8899a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

On 24/09/2018 21:04, Corentin Labbe wrote:
> This patch convert meson DRM driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c      | 14 ++++---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c   | 33 +++++++++--------
>  drivers/gpu/drm/meson/meson_plane.c     | 13 ++++---
>  drivers/gpu/drm/meson/meson_registers.h |  3 --
>  drivers/gpu/drm/meson/meson_venc.c      | 13 ++++---
>  drivers/gpu/drm/meson/meson_venc_cvbs.c |  4 +-
>  drivers/gpu/drm/meson/meson_viu.c       | 65 +++++++++++++++++----------------
>  drivers/gpu/drm/meson/meson_vpp.c       | 22 +++++------
>  8 files changed, 86 insertions(+), 81 deletions(-)
> 
[...]

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
