From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 17:20:38 -0500
Subject: [PATCH 9/9] dt-bindings: usb: mtk-xhci: remove dummy clocks and
 add optional ones
In-Reply-To: <95192dfda40c60cbe24b0f1e0bd6c82d318aa4ed.1506503880.git.chunfeng.yun@mediatek.com>
References: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1506503879.git.chunfeng.yun@mediatek.com>
 <95192dfda40c60cbe24b0f1e0bd6c82d318aa4ed.1506503880.git.chunfeng.yun@mediatek.com>
Message-ID: <20171005222038.4krmhf7wb6jkl6xp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 05:23:05PM +0800, Chunfeng Yun wrote:
> Remove dummy clocks for usb wakeup and add optional ones for
> MCU_BUS_CK and DMA_BUS_CK.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Seems a bit suspicious and not a backwards compatible change, but only 
affects your platforms, so:

Acked-by: Rob Herring <robh@kernel.org>
