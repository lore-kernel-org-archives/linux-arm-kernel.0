From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Jan 2018 12:39:09 -0600
Subject: [v2 PATCH 5/6] dt-bindings: usb: mtk-xhci: update USB wakeup
 properties
In-Reply-To: <7c7f69a3981b5117f7c8cc14b19c3459a50403ef.1514967463.git.chunfeng.yun@mediatek.com>
References: <41c6b0f2e959c07eff261060e57fd180a750071a.1514967463.git.chunfeng.yun@mediatek.com>
 <7c7f69a3981b5117f7c8cc14b19c3459a50403ef.1514967463.git.chunfeng.yun@mediatek.com>
Message-ID: <20180105183909.vhudoswb6bkq7xvf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 04:53:21PM +0800, Chunfeng Yun wrote:
> Add two arguments in "mediatek,syscon-wakeup" to support multi
> wakeup glue layer between SSUSB and SPM, and use standard property
> "wakeup-source" to replace the private "mediatek,wakeup-src"
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.txt        | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
