From: joe@perches.com (Joe Perches)
Date: Tue, 09 Oct 2018 18:41:44 -0700
Subject: [PATCH 15/36] dt-bindings: arm: Convert Actions Semi bindings
 to jsonschema
In-Reply-To: <c4909f78-bfa1-9253-e436-1159392b45a9@suse.de>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-16-robh@kernel.org>
 <c4909f78-bfa1-9253-e436-1159392b45a9@suse.de>
Message-ID: <fb2ffc4c5dc18825b508fd29c4dd44d260c9c193.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-10-06 at 12:40 +0200, Andreas F?rber wrote:
> > +++ b/Documentation/devicetree/bindings/arm/actions.yaml
[]
> > +
> > +title: Actions Semi platforms device tree bindings
> > +
> > +maintainers:
> > +  - Andreas F?rber <afaerber@suse.de>
> 
> Mani is now officially reviewer and the closest I have to a
> co-maintainer. I suggest we add him here in some form. I assume this is
> independent of MAINTAINERS patterns though, or will get_maintainers.pl
> parse this, too?

It _could_, if using the get_maintainers --file-emails option.
Ideally, it would be added to the MAINTAINERS somewhere.
