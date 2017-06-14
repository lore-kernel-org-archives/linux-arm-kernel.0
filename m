From: robh@kernel.org (Rob Herring)
Date: Wed, 14 Jun 2017 10:28:43 -0500
Subject: [PATCH 1/3] dt-bindings: Add support for samsung s6e63j0x03
 panel binding
In-Reply-To: <1496984354-5271-2-git-send-email-hoegeun.kwon@samsung.com>
References: <1496984354-5271-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170609045938epcas5p2025914487ca22a0a2d419824402e89e9@epcas5p2.samsung.com>
 <1496984354-5271-2-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170614152843.ppwqvk6qkkibt5vu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 01:59:12PM +0900, Hoegeun Kwon wrote:
> The Samsung s6e63j0x03 is a 1.63" 320x320 AMOLED panel connected using
> MIPI-DSI interfaces.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  .../bindings/display/panel/samsung,s6e63j0x03.txt  | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt

Acked-by: Rob Herring <robh@kernel.org>
