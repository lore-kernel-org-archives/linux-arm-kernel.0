From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 18:29:53 -0500
Subject: [PATCH v2 2/2] dt-bindings: i2c: Update documentation for
 "mv78230-a0-i2c"
In-Reply-To: <20171005110820.phcjh7dmygi43dhq@ninjato>
References: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
 <20170928213605.22874-3-kalyan.kinthada@alliedtelesis.co.nz>
 <87k20dmxw0.fsf@free-electrons.com>
 <20171005110820.phcjh7dmygi43dhq@ninjato>
Message-ID: <20171005232953.gsxs6ecp6kopolf2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 01:08:20PM +0200, Wolfram Sang wrote:
> On Mon, Oct 02, 2017 at 04:23:43PM +0200, Gregory CLEMENT wrote:
> > Hi Wolfram,
> >  
> >  On ven., sept. 29 2017, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz> wrote:
> > 
> > > This commit modifies the documentation for
> > > "marvell,mv78230-a0-i2c" compatible string.
> > >
> > > The "marvell,mv78230-a0-i2c" compatible string enables the workaround
> > > for an i2c repeated start timing violation, but unlike
> > > "marvell,mv78230-i2c" it disables the i2c offload support. This is
> > > applicable to a number of SoCs such as early revisions of the Armada XP
> > > and the Armada 38x.
> > >
> > > Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> > 
> > 
> > I applied the dt fix on my mvebu/fixes branch. Do you want to apply this
> > one on your branch, or do you prefer I take it. In this case an acked-by
> > would be nice.
> 
> I'd prefer to take it. What I'd really like to see here is an ack from
> Rob because of the previous discussion of an earlier revision of this
> patch.

I'm confused how mv78230 relates to Armada XP or 38x... I don't really 
want to know either. If normal compatible string conventions were 
followed then I wouldn't have to.

Rob
