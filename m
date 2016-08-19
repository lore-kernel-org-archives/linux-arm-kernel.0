From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Aug 2016 08:50:28 -0500
Subject: [PATCH v3 5/5] dt-bindings: add compatible strings for
 big/little rockchip vops
In-Reply-To: <1471554763-22202-1-git-send-email-seanpaul@chromium.org>
References: <1471454202-1631-1-git-send-email-seanpaul@chromium.org>
 <1471554763-22202-1-git-send-email-seanpaul@chromium.org>
Message-ID: <20160819135028.GA4972@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 02:12:43PM -0700, Sean Paul wrote:
> From: Mark Yao <mark.yao@rock-chips.com>
> 
> This patch documents the compatible strings for the big and little vop
> in rockchip's drm driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> 
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> [seanpaul removed superfluous description per tfiga's review]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
> 
> Resending to add devicetree list
> 
> Changes in v3:
> 	- Updated subject (Sean Paul)
> 	- Removed unnecessary description (Tomasz)
> 
>  Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
