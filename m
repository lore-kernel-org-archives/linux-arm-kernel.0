From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 16:48:02 -0600
Subject: [PATCH 1/3] dt-bindings: Document the dmas and dma-names
 properties for VC4 HDMI
In-Reply-To: <20170207210703.7082-1-eric@anholt.net>
References: <20170207210703.7082-1-eric@anholt.net>
Message-ID: <20170215224802.yotkqh4pdhfrilrb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 01:07:01PM -0800, Eric Anholt wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> These are optional, but necessary for HDMI audio support.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org> 
