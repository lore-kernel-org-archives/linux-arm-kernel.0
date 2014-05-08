From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Thu, 08 May 2014 16:28:28 -0700
Subject: [PATCH RFC v3 1/6] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <20140508085743.GA12860@e102568-lin.cambridge.arm.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1399399483-17112-2-git-send-email-lorenzo.pieralisi@arm.com>
 <536ac4ef.6ae7440a.511a.ffffdef8@mx.google.com>
 <20140508085743.GA12860@e102568-lin.cambridge.arm.com>
Message-ID: <536c131d.43d7440a.1d61.ffff95ca@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lorenzo Pieralisi (2014-05-08 01:57:43)
> On Thu, May 08, 2014 at 12:43:04AM +0100, Sebastian Capella wrote:
> > Quoting Lorenzo Pieralisi (2014-05-06 11:04:38)
> > > diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
> > > new file mode 100644
> > > index 0000000..196ef52
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/idle-states.txt
> > > @@ -0,0 +1,508 @@
...
> > > +
> > > +The nodes describing the idle states (state) can only be defined within the
> > > +idle-states node.
> > > +
> > > +Any other configuration is consider invalid and therefore must be ignored.
> > 
> > consider -> considered
> > must be -> shall?
> > 
> > Is the reference to "any other configuration" referring to state nodes
> > not in the idle states node?  If so, maybe this sentence should go
> > together with that one.
> 
> Yes, it makes sense.
> 

With this small change you can add my Reviewed-by

Thanks!

Sebastian
