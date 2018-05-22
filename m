From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 15:57:47 -0500
Subject: [PATCH] media: rcar-vin:  Drop unnecessary register properties
 from example vin port
In-Reply-To: <20180509184558.14960-1-horms+renesas@verge.net.au>
References: <20180509184558.14960-1-horms+renesas@verge.net.au>
Message-ID: <20180522205747.GA2795@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 08:45:58PM +0200, Simon Horman wrote:
> The example vin port node does not have an address and thus does not
> need address-cells or address size-properties.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/media/rcar_vin.txt | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
