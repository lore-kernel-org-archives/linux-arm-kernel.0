From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Oct 2017 16:58:39 -0500
Subject: [PATCH v8 01/10] dt-bindings: net: Restore sun8i dwmac binding
In-Reply-To: <20171023185626.31793-2-clabbe.montjoie@gmail.com>
References: <20171023185626.31793-1-clabbe.montjoie@gmail.com>
 <20171023185626.31793-2-clabbe.montjoie@gmail.com>
Message-ID: <20171023215839.3brzm4nhptkkdbwq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 08:56:17PM +0200, Corentin Labbe wrote:
> The original dwmac-sun8i DT bindings have some issue on how to handle
> integrated PHY and was reverted in last RC of 4.13.
> But now we have a solution so we need to get back that was reverted.
> 
> This patch restore dt-bindings documentation about dwmac-sun8i
> This reverts commit 8aa33ec2f481 ("dt-bindings: net: Revert sun8i dwmac binding")
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../devicetree/bindings/net/dwmac-sun8i.txt        | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt

Please add acks when posting new versions.

Acked-by: Rob Herring <robh@kernel.org> 

Rob
