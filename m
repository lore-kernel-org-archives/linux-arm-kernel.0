From: robh@kernel.org (Rob Herring)
Date: Mon, 13 Jun 2016 13:54:54 -0500
Subject: [PATCH v3,1/5] dt-bindings: mt8173-xhci: support host side of
 dual-role mode
In-Reply-To: <1465543962-11678-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
 <1465543962-11678-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20160613185454.GA21742@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 03:32:38PM +0800, Chunfeng Yun wrote:
> Some resources, such as IPPC register etc, shared with device
> driver are moved into common glue layer when xHCI driver is the
> host side of dual-role mode and they should be changed as optional
> properties if they are required ones before. For clarity, add
> a new part of binding to support host side of dual-role mode.
> 
> Additionally add optional properties of pinctrl for host only mode
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mt8173-xhci.txt        |   48 ++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
