From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 16:38:54 -0600
Subject: [PATCH v3 8/8] dt-bindings: phy-mt65xx-usb: add support for new
 version phy
In-Reply-To: <1487753705-6745-8-git-send-email-chunfeng.yun@mediatek.com>
References: <1487753705-6745-1-git-send-email-chunfeng.yun@mediatek.com>
 <1487753705-6745-8-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20170227223853.htphbxx2hyvll6fd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 04:55:05PM +0800, Chunfeng Yun wrote:
> add a new compatible string for "mt2712", and move reference clock
> into each port node;
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |   93 +++++++++++++++++---
>  1 file changed, 80 insertions(+), 13 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
