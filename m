From: robh@kernel.org (Rob Herring)
Date: Mon, 20 Mar 2017 10:09:06 -0500
Subject: [PATCH v2 06/11] Documentation: DT: bindings: input:
 touschcreen: remove sun4i documentation
In-Reply-To: <20170310103921.19469-7-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-7-quentin.schulz@free-electrons.com>
Message-ID: <20170320150906.piixax6ejrpm6ljv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 11:39:16AM +0100, Quentin Schulz wrote:
> This patch removes the sun4i touchscreen controller binding
> documentation since it has been merged with the sun4i GPADC binding
> documentation.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> added in v2
> 
>  .../bindings/input/touchscreen/sun4i.txt           | 38 ----------------------
>  1 file changed, 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/sun4i.txt

Acked-by: Rob Herring <robh@kernel.org>
