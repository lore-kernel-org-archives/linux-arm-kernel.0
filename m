From: ruxandra.radulescu@nxp.com (Ruxandra Ioana Radulescu)
Date: Thu, 20 Apr 2017 08:31:11 +0000
Subject: [PATCH v2 8/9] staging: fsl-dpaa2/eth: Add TODO file
In-Reply-To: <CAEac7ta6h=_TT9MCZc8G4-raN47HrAphKf4ufUurX+zoOjm1gQ@mail.gmail.com>
References: <20170412162538.25302-1-ruxandra.radulescu@nxp.com>
 <20170412162538.25302-9-ruxandra.radulescu@nxp.com>
 <CAEac7ta6h=_TT9MCZc8G4-raN47HrAphKf4ufUurX+zoOjm1gQ@mail.gmail.com>
Message-ID: <VI1PR0402MB2847F22CFB1811943C29B1E7941B0@VI1PR0402MB2847.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stuart Yoder [mailto:stuyoder at gmail.com]
> Sent: Wednesday, April 19, 2017 6:44 AM
> To: Ruxandra Ioana Radulescu <ruxandra.radulescu@nxp.com>
> Cc: gregkh at linuxfoundation.org; devel at driverdev.osuosl.org; linux-
> kernel at vger.kernel.org; Alexander Graf <agraf@suse.de>; Arnd Bergmann
> <arnd@arndb.de>; linux-arm-kernel at lists.infradead.org; Alexandru
> Marginean <alexandru.marginean@nxp.com>; Bogdan Hamciuc
> <bogdan.hamciuc@nxp.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> Roy Pledge <roy.pledge@nxp.com>; Haiying Wang
> <haiying.wang@nxp.com>
> Subject: Re: [PATCH v2 8/9] staging: fsl-dpaa2/eth: Add TODO file
> 
> On Wed, Apr 12, 2017 at 11:25 AM, Ioana Radulescu
> <ruxandra.radulescu@nxp.com> wrote:
> > Add a list of TODO items for the Ethernet driver
> >
> > Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> > ---
> > v2: Add note
> >
> >  drivers/staging/fsl-dpaa2/ethernet/TODO | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 drivers/staging/fsl-dpaa2/ethernet/TODO
> >
> > diff --git a/drivers/staging/fsl-dpaa2/ethernet/TODO b/drivers/staging/fsl-
> dpaa2/ethernet/TODO
> > new file mode 100644
> > index 000000000000..110e66d44b42
> > --- /dev/null
> > +++ b/drivers/staging/fsl-dpaa2/ethernet/TODO
> > @@ -0,0 +1,14 @@
> > +* Add a DPAA2 MAC kernel driver in order to allow PHY management;
> currently
> > +  the DPMAC objects and their link to DPNIs are handled by MC internally
> > +  and all PHYs are seen as fixed-link
> > +* add more debug support: decide how to expose detailed debug
> statistics,
> > +  add ingress error queue support
> > +* MC firmware uprev; the DPAA2 objects used by the Ethernet driver
> need to
> > +  be kept in sync with binary interface changes in MC
> > +* refine README file
> > +* cleanup
> > +
> > +NOTE: None of the above is must-have before getting the DPAA2
> Ethernet driver
> > +out of staging. The main requirement for that is to have the drivers it
> > +depends on, fsl-mc bus and DPIO driver, moved to drivers/bus and
> drivers/soc
> > +respectively.
> 
> The TODO file should have contact info (I think)...look at other
> drivers/staging TODO
> for examples.

Thanks Stuart, I missed that. If I send a v3 of this patchset I'll include
this update, otherwise I'll send a separate patch for it.

Ioana
