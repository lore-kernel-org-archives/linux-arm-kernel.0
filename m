From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2011 13:39:48 +0100
Subject: [RFC][PATCH 4/5] ARM: S5P64x0: Adding OTG PHY control code
In-Reply-To: <BANLkTim+idO=XDtcvYZdfUToROnb8ju+kQ@mail.gmail.com>
References: <0LN4003P2ZGJSGU0@mailout4.samsung.com>
	<BANLkTim+idO=XDtcvYZdfUToROnb8ju+kQ@mail.gmail.com>
Message-ID: <20110621123948.GF23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 05:56:05PM +0530, Praveen Paneri wrote:
> Hi,
> 
> On Tue, Jun 21, 2011 at 4:20 PM, PRAVEEN PANERI <p.paneri@samsung.com> wrote:

Err, that attributation is wrong.

> > On Tue, Jun 21, 2011 at 12:33:46PM +0530, p.paneri at samsung.com wrote:
> > > +#include
> > > +#include
> > > +#include
> > > +#include
> > > +#include
> > > +#include
> > > +#include
> >
> > linux/gpio.h please.
> will change it

You should question why your mailer decided to remove the contents after
the "#include" when quoting.  Maybe you need to get a better mailer, fix
some configuration setting, or complain to google that gmail is messing
with emails in ways it shouldn't.

However, I doubt that gmail itself is as broken as it appears to be
above... but whatever it is, it needs fixing.
