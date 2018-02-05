From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:08:30 -0600
Subject: [PATCH 2/2] dt-bindings: PCI: MediaTek: Correct the
 interrupt-map properties
In-Reply-To: <9d247a4fba54ba90d07df32fd89a8bb2c8bdb0f9.1516961656.git.ryder.lee@mediatek.com>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
 <9d247a4fba54ba90d07df32fd89a8bb2c8bdb0f9.1516961656.git.ryder.lee@mediatek.com>
Message-ID: <20180205060830.svkrwnn6wzuig7ns@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 03:41:50PM +0800, Ryder Lee wrote:
> Move the interrupt-map properties from the child nodes to the root node
> and update each entry accordingly.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie.txt      | 28 ++++++++++++----------
>  1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
