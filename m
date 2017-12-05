From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 09:55:58 +0100
Subject: [PATCH v4 00/10] add pinmuxing support for pins in AXP209 and
 AXP813 PMICs
In-Reply-To: <CACRpkdaMxaLjsDETm6_56tyGDu6=W0L4SQCAA2mmSR4mkR-jAA@mail.gmail.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <CACRpkdaMxaLjsDETm6_56tyGDu6=W0L4SQCAA2mmSR4mkR-jAA@mail.gmail.com>
Message-ID: <20171205085558.ernawgdgybd4lzxx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 02, 2017 at 05:00:03PM +0100, Linus Walleij wrote:
> On Fri, Dec 1, 2017 at 2:44 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> 
> > The AXP209 and AXP813 PMICs have several pins (respectively 3 and 2) that can
> > be used either as GPIOs or for other purposes (ADC or LDO here).
> >
> > We already have a GPIO driver for the GPIO use of those pins on the AXP209.
> > Let's "upgrade" this driver to support all the functions these pins can have.
> >
> > Then we add support to this driver for the AXP813 which is slighlty different
> > (basically a different offset in two registers and one less pin).
> >
> > I suggest patches 1 to 8 go through Linus's tree and 9 and 10 via Maxime or
> > Chen-Yu's tree.
> >
> > v4:
> 
> Looks overall good. As soon as Maxime is happy with everything I will
> happily apply 1-8 to the pinctrl tree and then pull it to GPIO as well to
> avoid clashes.
> 
> I think there were some minor comments but it seems almost finished.

You can apply everything with my
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

The only comment left is the checkpatch warning, but there's multiple
occurences of that issue in the driver, so it can definitely be done
in a separate patch.

(But please do it Quentin ;))

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/f8fc76b8/attachment.sig>
