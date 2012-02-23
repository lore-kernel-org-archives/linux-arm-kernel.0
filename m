From: jason@lakedaemon.net (Jason)
Date: Thu, 23 Feb 2012 14:00:59 -0500
Subject: [PATCH 2/3 v4] arm: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <CACxGe6veKy3eA=GCp9eZWG1h8UgEYwAP9aicJhwm90=m4Z33xg@mail.gmail.com>
References: <cover.1329936660.git.jason@lakedaemon.net>
 <8532afcdc4adbb3771e6f742bcc33ef9c0347858.1329936660.git.jason@lakedaemon.net>
 <4F45B043.1080302@gmail.com> <201202230734.33583.arnd@arndb.de>
 <20120223161210.GN23524@titan.lakedaemon.net>
 <CACxGe6veKy3eA=GCp9eZWG1h8UgEYwAP9aicJhwm90=m4Z33xg@mail.gmail.com>
Message-ID: <20120223190059.GO23524@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 11:56:46AM -0700, Grant Likely wrote:
> On Thu, Feb 23, 2012 at 9:12 AM, Jason <jason@lakedaemon.net> wrote:
> > On Thu, Feb 23, 2012 at 07:34:33AM +0000, Arnd Bergmann wrote:
> >> On Thursday 23 February 2012, Rob Herring wrote:
> >> > On 02/22/2012 01:18 PM, Jason Cooper wrote:
...
> >> > > +
> >> > > +static const char *kirkwood_dt_board_compat[] = {
> >> > > + "marvell,dreamplug",
> >> > > + NULL
> >> > > +};
> >>
> >> Since you mention the name, it should probably be "globalscale,dreamplug"
> >> because the device is made by GlobalScale instead of Marvell.
> >
> > hmm, Globalscale Tech is, as I understand it, a turn-key manufacturer.
> > They are simply building Marvell's development platforms for them,
> > handling sales, etc. ?My impression was that Marvell designed the board
> > and contracted Globalscale to build and distribute it.
> >
> > I don't care which we use, but is the convention to use the SoC designer
> > (marvell,dreamplug), the SoC (kirkwood,dreamplug), or the brand
> > (globalscale,dreamplug)?
> >
> > If there is no set standard, I think the SoC is most accurate, as
> > nothing prevents a manufacturer from swapping out ICs/SoCs between
> > manufacturing runs of the same make/model. ?Look at certain wifi USB
> > devices for examples.
> 
> convention is to use the vendor of the device.  If it is marketed as a
> Marvell product, then use "marvell,...".  If it is Globalscale, then
> "globalscale,...".  The actual SoC on the device is irrelevant for the
> top level compatible property name.

globalscale it is, then.  Thanks for the clarification.

thx,

Jason.
