From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Feb 2015 11:59:51 +0100
Subject: imx_v6_v7_defconfig needs lzop
In-Reply-To: <CAMuHMdXJCh32e-+7rqNzCdbYX4AH3qfBQ3uZ_t9kC_8+1P1jJQ@mail.gmail.com>
References: <CAMuHMdVjqp52BQqH32Ut7kxDYzmyY4+JEVuhXgTqU8V24kQyZA@mail.gmail.com>
 <CAOMZO5Dh0Wv61Y0J_Ue1G=Y8vc23yM2Fxq6CqhpmNBHa-2Lkvg@mail.gmail.com>
 <CAMuHMdXJCh32e-+7rqNzCdbYX4AH3qfBQ3uZ_t9kC_8+1P1jJQ@mail.gmail.com>
Message-ID: <20150205105951.GU10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 04, 2015 at 03:41:45PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 4, 2015 at 3:32 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Wed, Feb 4, 2015 at 12:21 PM, Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> http://kisskb.ellerman.id.au/kisskb/buildresult/12358024/
> >>
> >> /bin/sh: 1: lzop: not found
> >> cat: write error: Broken pipe
> >> make[3]: *** [arch/arm/boot/compressed/piggy.lzo] Error 1
> >
> > Isn't this error happening due to the lack of 'lzop' package installed
> > on the host machine?
> 
> Indeed.
I guess you don't want to ask for help or report a build breakage, but
question if it's sensible to let a defconfig depend on a host tool that
isn't commonly installed, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
