From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:44:44 -0400
Subject: [PATCH 09/27] dt-bindings: display: sun4i-drm: Add H6 display
 engine compatibles
In-Reply-To: <20180902072643.4917-10-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-10-jernej.skrabec@siol.net>
Message-ID: <5b9f3f4d.1c69fb81.c776b.ee42@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  2 Sep 2018 09:26:25 +0200, Jernej Skrabec wrote:
> This commit adds compatibles used in H6 display pipeline, namely for
> display engine, mixer and TV TCON.
> 
> H6 display engine is somewhat similar to R40, just less TCONs and
> mixer support more features.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
