From: matt@genesi-usa.com (Matt Sealey)
Date: Sun, 23 Dec 2012 10:42:47 -0000
Subject: [PATCH 4/4] efikamx: remove Efika MX-specific CHRGVBUS hack from
 the USB driver
In-Reply-To: <CAOMZO5CcUZ8NKM6uHkBB1Yo9MjeoBq9NzpOYwT1squM4TOgV7g@mail.gmail.com>
References: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
 <1343843371-14143-5-git-send-email-matt@genesi-usa.com>
 <CAOMZO5CcUZ8NKM6uHkBB1Yo9MjeoBq9NzpOYwT1squM4TOgV7g@mail.gmail.com>
Message-ID: <CAKGA1bnzYWG5POJ228ytayXztoXcMXt2rB-4S6fnrv5Gxo_=TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anyone got a clue who the actual USB maintainer is who cares about ehci-mxc?

Best search through the maintainers file is Li Yang <leoli@freescale.com>
and of course I could always nudge David Brownell, Sascha (your name is at
the top of the file!)

I was going to resubmit on Friday and push an alternative patch to the
chipidea driver but I can't figure out who's in control, if the only
nitpick is I didn't CC the right people then this could take many, many
submissions while this gets figured out :D

Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.


On Sun, Sep 9, 2012 at 10:00 PM, Fabio Estevam <festevam@gmail.com> wrote:

> On Wed, Aug 1, 2012 at 2:49 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> > Since we're removing Efika MX support from the tree (for now), remove
> > the hack present in the USB host driver since it will never run and
> > isn't useful on any other systems.
> >
> > Signed-off-by: Matt Sealey <matt@genesi-usa.com>
>
> You should Cc linux-usb list and the USB maintainer on this one.
>
> Regards,
>
> Fabio Estevam
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121223/1f8e3164/attachment-0001.html>
