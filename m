From: robh@kernel.org (Rob Herring)
Date: Mon, 23 May 2016 16:38:34 -0500
Subject: [PATCH 1/3] dt-bindings: add used but undocumented rockchip grf
 compatible values
In-Reply-To: <1464015539-19521-2-git-send-email-heiko@sntech.de>
References: <1464015539-19521-1-git-send-email-heiko@sntech.de>
 <1464015539-19521-2-git-send-email-heiko@sntech.de>
Message-ID: <20160523213834.GA12860@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 04:58:57PM +0200, Heiko Stuebner wrote:
> There are some more General Register Files used in devicetree files
> already, but as of now undocumented in the binding document, fix that.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
