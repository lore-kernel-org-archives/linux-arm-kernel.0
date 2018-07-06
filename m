From: robh@kernel.org (Rob Herring)
Date: Fri, 6 Jul 2018 14:40:52 -0600
Subject: [PATCH 06/17] dt-bindings: display: sun4i-drm: Add R40 TV TCON
 description
In-Reply-To: <20180706175113.26698-7-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-7-jernej.skrabec@siol.net>
Message-ID: <20180706204052.GA9680@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 07:51:02PM +0200, Jernej Skrabec wrote:
> TCON description is expanded with R40 TV TCON compatible. It is a bit
> special, because it is connected to TCON TOP instead directly to mixer
> and it needs special handling.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Please add acks/reviews when posting new versions.

Rob
