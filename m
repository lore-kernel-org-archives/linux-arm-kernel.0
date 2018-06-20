From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 13:08:28 -0600
Subject: [PATCH v3 1/2] dt-bindings: mmc: broken clock stable indicator
 on arasan controllers
In-Reply-To: <12953dbf9af1f1a71aaf3ef77782e56a2a7ad893.1529493667.git.h.grohne@intenta.de>
References: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
 <cover.1529493667.git.h.grohne@intenta.de>
 <12953dbf9af1f1a71aaf3ef77782e56a2a7ad893.1529493667.git.h.grohne@intenta.de>
Message-ID: <20180620190828.GA26510@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 01:32:51PM +0200, Helmut Grohne wrote:
> Some controllers immediately report that their internal clock is stable
> after activating it even when the clock is not stable. When used in
> conjunction with older/slower cards, this can result in:
> 
>     mmc0: error -84 whilst initialising SD card
> 
> This flag allows documenting and thus working around such a hardware
> defect.
> 
> Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
