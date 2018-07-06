From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 06 Jul 2018 22:44:20 +0200
Subject: [PATCH 06/17] dt-bindings: display: sun4i-drm: Add R40 TV TCON
 description
In-Reply-To: <20180706204052.GA9680@rob-hp-laptop>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-7-jernej.skrabec@siol.net>
 <20180706204052.GA9680@rob-hp-laptop>
Message-ID: <8232482.X57NU8v1zb@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne petek, 06. julij 2018 ob 22:40:52 CEST je Rob Herring napisal(a):
> On Fri, Jul 06, 2018 at 07:51:02PM +0200, Jernej Skrabec wrote:
> > TCON description is expanded with R40 TV TCON compatible. It is a bit
> > special, because it is connected to TCON TOP instead directly to mixer
> > and it needs special handling.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Please add acks/reviews when posting new versions.

This is not exactly the same version you give ack for, so I didn't include it. 
I'm not sure where the line for that is.

In contrast to previous version, it doesn't introduce additional clock.

Best regards,
Jernej
