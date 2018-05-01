From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 11:17:23 -0500
Subject: [PATCH 04/21] bindings: display: Add compatible for A64 DE2
 pipeline
In-Reply-To: <20180430114058.5061-5-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-5-jagan@amarulasolutions.com>
Message-ID: <20180501161723.GA376@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 05:10:41PM +0530, Jagan Teki wrote:
> Allwinner A64 has DE2 pipeline similar to other Allwinner
> SOC's like A83T, H3/H5.

'dt-bindings: ' for the subject prefix.

> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
