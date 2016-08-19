From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Aug 2016 08:51:30 -0500
Subject: [PATCH v3 2/5] dt-bindings: sort Rockchip vop compatible by
 chip's number
In-Reply-To: <1471554918-22353-1-git-send-email-seanpaul@chromium.org>
References: <loom.20160602T085439-162@post.gmane.org>
 <1471554918-22353-1-git-send-email-seanpaul@chromium.org>
Message-ID: <20160819135130.GA5345@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 02:15:18PM -0700, Sean Paul wrote:
> From: Mark Yao <mark.yao@rock-chips.com>
> 
> Reorder the compatible vop devices to be sorted by chip number
> in ascending order.
> 
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> [seanpaul added commit description per tfiga's review]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
> 
> Resending to add devicetree list
> 
> Changes in v3:
> 	- Updated commit message (Tomasz Figa)
> 
>  Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
