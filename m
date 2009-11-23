From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 23 Nov 2009 16:31:11 +0100
Subject: [PATCH] MX27: Add USB platform devices and resources
In-Reply-To: <37367b3a0911230718s3dd16d99n1b2ce858b79218ca@mail.gmail.com>
References: <eedb5540907150626m3dbf815bif92ff179b6ebfe58@mail.gmail.com>
	<20090716081235.GQ2714@pengutronix.de>
	<37367b3a0911230436i5d44cd80y182316ef056d6b31@mail.gmail.com>
	<37367b3a0911230718s3dd16d99n1b2ce858b79218ca@mail.gmail.com>
Message-ID: <20091123153111.GM14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2009 at 01:18:03PM -0200, Alan Carvalho de Assis wrote:
> Now sending to right linux-arm address...
> 
> On 11/23/09, Alan Carvalho de Assis <acassis@gmail.com> wrote:
> > Hi Sascha,
> >
> > On 7/16/09, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> On Wed, Jul 15, 2009 at 03:26:21PM +0200, javier Martin wrote:
> >>> This adds clocks and resources for usb in i.mx27 SoC.
> >>
> >> Ok, applied to mxc-master.
> >>
> >
> > What do we need now to get USB working on i.MX27?
> >
> 
> (replying myself)
> I think this Daniel Mack's patch will be necessary:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-June/002972.html

The patch you refer to only contains the relevant bits for MX31, you
would need to tweak it a little to make MX27 work as well. I think this
has been done already by someone, but I can't remember exactly.

> Sascha, what is missing to this patch be applied?

The patch above and some others are already queued for 2.6.33. The ARM
specific things are in Sascha's mxc-master, the rest in the USB tree.

Daniel
