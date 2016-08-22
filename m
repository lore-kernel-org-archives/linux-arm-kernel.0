From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 22 Aug 2016 12:47:51 +0200
Subject: [PATCH] dt-binding: correct the larb port offset defines for
 mt2701
In-Reply-To: <1470902828-32496-1-git-send-email-honghui.zhang@mediatek.com>
References: <1470902828-32496-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20160822104751.GA17198@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 04:07:08PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> larb2 have 23 ports, the LARB3_PORT_OFFSET should be LARB2_PORT_OFFSET
> plus larb2's port number, it should be 44 instead of 43.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  include/dt-bindings/memory/mt2701-larb-port.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
