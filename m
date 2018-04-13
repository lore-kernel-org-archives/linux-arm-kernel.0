From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 12:27:18 -0500
Subject: [PATCH net-next 2/3] dt-bindings: net: ave: add syscon-phy-mode
 property to configure phy-mode setting
In-Reply-To: <1523255925-6469-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1523255925-6469-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1523255925-6469-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20180413172718.j2kmpjtdpuldqsj4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 03:38:44PM +0900, Kunihiko Hayashi wrote:
> Add "socionext,syscon-phy-mode" property to specify system controller that
> configures the settings about phy-mode.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
