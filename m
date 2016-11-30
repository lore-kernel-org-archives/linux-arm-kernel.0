From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Nov 2016 17:58:54 +0200
Subject: [PATCH v2 3/4] dt-bindings: display: add Amlogic Meson DRM
 Bindings
In-Reply-To: <1480520625-13269-4-git-send-email-narmstrong@baylibre.com>
References: <1480520625-13269-1-git-send-email-narmstrong@baylibre.com>
 <1480520625-13269-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <2734274.BAOZxRirYz@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Wednesday 30 Nov 2016 16:43:44 Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/meson/meson-drm.txt           | 101 ++++++++++++++++++

I forgot to mention that the file should not be named meson-drm.txt as DRM is 
a Linux-specific concept. You can name it meson.txt, but a better option would 
be amlogic,meson.txt. By the way does it really need a subdirectory ?

>  1 file changed, 101 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/meson/meson-drm.txt

-- 
Regards,

Laurent Pinchart
