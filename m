From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 14:12:16 -0500
Subject: [PATCH v2 5/5] dt-bindings: PCI: add support for new generation
 controller
In-Reply-To: <54392579509fd9b9b4635559c1c4e32be63d9781.1501125202.git.honghui.zhang@mediatek.com>
References: <cover.1501125202.git.honghui.zhang@mediatek.com>
 <54392579509fd9b9b4635559c1c4e32be63d9781.1501125202.git.honghui.zhang@mediatek.com>
Message-ID: <20170803191216.sox2avhvxyharbst@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 11:14:21AM +0800, honghui.zhang at mediatek.com wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> Add support for MediaTek new generation controller and update related
> properities.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie.txt      | 168 ++++++++++++++++++++-
>  1 file changed, 161 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
