From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 09:51:43 -0500
Subject: [PATCH 1/2] dt-bindings: net: mediatek: update documentation for
 reset signals
In-Reply-To: <302c3965ce2bde6354cee7614852096e6cfdf6b9.1498030300.git.sean.wang@mediatek.com>
References: <cover.1498030300.git.sean.wang@mediatek.com>
 <302c3965ce2bde6354cee7614852096e6cfdf6b9.1498030300.git.sean.wang@mediatek.com>
Message-ID: <20170626145143.fdztj3koh5gumblu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 03:49:51PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Since there's no user for the property reset inside the ethernet node
> for current supported MediaTek SoCs and boards, so it should be safe to
> update reset property in the bindings to introduce more reset signals as
> corresponding that commit 7c2adaf11036 ("reset: mediatek: Add MT2701 ethsys
> reset controller include file") did in order to be referenced them from
> within a devicetree file.
> 
> Cc: John Crispin <john@phrozen.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/net/mediatek-net.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
