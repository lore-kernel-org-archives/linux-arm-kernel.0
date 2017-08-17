From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 16:44:43 -0500
Subject: [PATCH 1/5] dt-bindings: reset: Add Realtek RTD1295
In-Reply-To: <20170816003847.6208-2-afaerber@suse.de>
References: <20170816003847.6208-1-afaerber@suse.de>
 <20170816003847.6208-2-afaerber@suse.de>
Message-ID: <20170817214443.lez5nxhstkt2pngc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 02:38:43AM +0200, Andreas F?rber wrote:
> Add binding for Realtek RTD1295 reset controller.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  .../bindings/reset/realtek,rtd129x-reset.txt       |  18 ++++
>  include/dt-bindings/reset/realtek,rtd1295.h        | 112 +++++++++++++++++++++
>  2 files changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/realtek,rtd129x-reset.txt
>  create mode 100644 include/dt-bindings/reset/realtek,rtd1295.h

Acked-by: Rob Herring <robh@kernel.org>
