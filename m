From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 12:54:39 -0500
Subject: [PATCH v4 1/9] dt-bindings: arm: mediatek: update for MT7623n
 SoC and relevant boards
In-Reply-To: <ec281bfc67e633873bb519e607aca67213454b6d.1495683769.git.sean.wang@mediatek.com>
References: <cover.1495683769.git.sean.wang@mediatek.com>
 <ec281bfc67e633873bb519e607aca67213454b6d.1495683769.git.sean.wang@mediatek.com>
Message-ID: <20170531175439.bclgr4atbxrmgpna@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 12:02:39PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Because there are two versions of MT7623 SoC that is MT7623a and MT7623n
> respectively. So update the part of MT7623n bindings to allow that people
> tend to differentiate which MT7623 SoC the boards applies.
> 
> And "mediatek,mt7623-evb" can be safely changed to
> "mediatek,mt7623n-rfb-nand" because mt7623-evb is a kind of debug board
> internally in Mediatek which real users can't get. So instead we should
> indicate which variants it belongs to with more specific postfix as the
> adding here to let people easily know what board they use.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
