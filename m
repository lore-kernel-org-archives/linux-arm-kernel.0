From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:44:42 -0400
Subject: [PATCH 07/27] dt-bindings: clock: sun8i-de2: Add H6 DE3 clock
 description
In-Reply-To: <20180902072643.4917-8-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-8-jernej.skrabec@siol.net>
Message-ID: <5b9f3f4b.1c69fb81.21dc0.dc17@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  2 Sep 2018 09:26:23 +0200, Jernej Skrabec wrote:
> This commit adds necessary description and dt includes for H6 DE3 clock.
> It is very similar to others, but memory region has some additional
> registers not found in DE2.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 5 +++--
>  include/dt-bindings/clock/sun8i-de2.h                 | 3 +++
>  include/dt-bindings/reset/sun8i-de2.h                 | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
