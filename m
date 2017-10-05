From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 15:59:56 -0500
Subject: [PATCH v6 01/11] dt-bindings: net: Restore sun8i dwmac binding
In-Reply-To: <20170927073414.17361-2-clabbe.montjoie@gmail.com>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
 <20170927073414.17361-2-clabbe.montjoie@gmail.com>
Message-ID: <20171005205956.2wy26t4mugbowucn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 09:34:04AM +0200, Corentin Labbe wrote:
> This patch restore dt-bindings documentation about dwmac-sun8i
> This reverts commit 8aa33ec2f481 ("dt-bindings: net: Revert sun8i dwmac binding")

What's missing here is why you are reverting?

> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../devicetree/bindings/net/dwmac-sun8i.txt        | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
