From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 16:38:17 -0500
Subject: [PATCH v1 2/2] dt-bindings: crypto: remove mediatek ethif clock
In-Reply-To: <1496284222-12560-3-git-send-email-ryder.lee@mediatek.com>
References: <1496284222-12560-1-git-send-email-ryder.lee@mediatek.com>
 <1496284222-12560-3-git-send-email-ryder.lee@mediatek.com>
Message-ID: <20170607213817.nr3n6vdrchspcc5i@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 10:30:22AM +0800, Ryder Lee wrote:
> This patch removes the parent clock 'ethif' in bindings, since we don't
> need to control the parent of a clock in current clock framework.
> 
> Moreover, the clocks are get by name in the driver, thus this change
> does not break backwards compatibility.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Documentation/devicetree/bindings/crypto/mediatek-crypto.txt | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
