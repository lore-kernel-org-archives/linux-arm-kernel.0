From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Jan 2012 02:31:13 -0800
Subject: Pinmux bindings proposal
In-Reply-To: <20120118202057.GH4223@ponder.secretlab.ca>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <20120116182808.GG4223@ponder.secretlab.ca>
 <20120118141329.GA22818@atomide.com>
 <CAAQ0ZWTtYz3Lg7=Xz29m07j_k8yA95hn6cyk92SAJ4iGJRT_gw@mail.gmail.com>
 <20120118153256.GB22818@atomide.com>
 <20120118202057.GH4223@ponder.secretlab.ca>
Message-ID: <20120119103112.GD22818@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [120118 11:48]:
> On Wed, Jan 18, 2012 at 07:32:56AM -0800, Tony Lindgren wrote:
> > 
> > But then the .dts file becomes an unreadable matrix unless we have
> > a preprocessor..
> 
> One node per pin does get excessive in a hurry.  I prefer the one node
> per pin controller.  Tools can be written to make writing the
> definition easier.
 
OK that's fine with me. It would be nice to have the .dts readable
too, so I'd prefer a preprocessor over a .dts generation tool to
keep the .dts files readable. Bugs in .dts file can be a big pain
to debug it seems.

Regards,

Tony
