From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 25 Apr 2016 11:56:22 -0400
Subject: [PATCH v2 1/4] dt-bindings: interrupt-controllers: add
 description of SIC1 and SIC2
In-Reply-To: <20160425145124.GA23792@rob-hp-laptop>
References: <1461545990-25560-1-git-send-email-vz@mleia.com>
 <1461546023-25614-1-git-send-email-vz@mleia.com>
 <20160425145124.GA23792@rob-hp-laptop>
Message-ID: <1461599782.6934.0.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-04-25 at 09:51 -0500, Rob Herring wrote:
> On Mon, Apr 25, 2016 at 04:00:23AM +0300, Vladimir Zapolskiy wrote:
> > NXP LPC32xx has three interrupt controllers, namely root Main
> > Interrupt Controller (MIC) and two supplementary Sub Interrupt
> > Controllers (SIC1 and SIC2), four interrupt outputs from SIC1 and SIC2
> > are connected to MIC.
> > 
> > Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> > ---
> > Changes from v1 to v2:
> > * removed introduced optional "interrupt-controller-name" property,
> >   for users the name of a controller will be constructed from mic/sic
> >   and controller physical address,
> > * removed introduced optional "wakeup-sources" property, a list of
> >   mappings between a hardware interrupt and its correspondent wakeup source
> >   to exit CPU STOP mode will be discussed later on,
> > * other negligible changes (rewording, small letters in unit address etc.)
> > 
> >  .../interrupt-controller/nxp,lpc3220-mic.txt       | 70 ++++++++++++++--------
> >  1 file changed, 46 insertions(+), 24 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
