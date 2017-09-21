From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Sep 2017 11:07:58 +0200
Subject: [PATCH v2 6/8] arm64: renesas: document Eagle board bindings
In-Reply-To: <20170920205233.jjncu7fzi6cmoggq@rob-hp-laptop>
References: <20170915194442.464361390@cogentembedded.com>
 <20170920205233.jjncu7fzi6cmoggq@rob-hp-laptop>
Message-ID: <20170921090754.GT15749@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 03:52:33PM -0500, Rob Herring wrote:
> On Fri, Sep 15, 2017 at 10:43:24PM +0300, Sergei Shtylyov wrote:
> > Document the Eagle device tree bindings, listing it as a supported board.
> > 
> > This allows to use checkpatch.pl to validate .dts files referring to the
> > Eagle board.
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> > Changes in version 2:
> > - renamed the patch.
> > 
> >  Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > Index: renesas/Documentation/devicetree/bindings/arm/shmobile.txt
> > ===================================================================
> > --- renesas.orig/Documentation/devicetree/bindings/arm/shmobile.txt
> > +++ renesas/Documentation/devicetree/bindings/arm/shmobile.txt
> > @@ -59,6 +59,8 @@ Boards:
> >      compatible = "renesas,bockw", "renesas,r8a7778"
> >    - Draak (RTP0RC77995SEB0010S)
> >      compatible = "renesas,draak", "renesas,r8a77995"
> > +  - Eagle (RTP0RC77970SEB0010S)
> > +    compatible = "renesas,eagle", "renesas,r8a77970";
> 
> You're not consistent here with the ';'.
> 
> Otherwise,
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, applied with Rob and Geert's tags and without the ';'.
