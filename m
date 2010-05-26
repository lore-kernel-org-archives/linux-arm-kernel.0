From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 26 May 2010 16:23:02 +0200
Subject: [PATCH 7/8] pxa/income: Add Income SBC support
In-Reply-To: <AANLkTilAieHQmA5ltgsnKw0NrzG-Lvcj5_W4VsL-iejC@mail.gmail.com>
References: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
	<1274480980-10109-8-git-send-email-marek.vasut@gmail.com>
	<20100524110155.GH30801@buzzloop.caiaq.de>
	<AANLkTilAieHQmA5ltgsnKw0NrzG-Lvcj5_W4VsL-iejC@mail.gmail.com>
Message-ID: <20100526142302.GC2695@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, May 26, 2010 at 10:18:19PM +0800, Eric Miao wrote:
> On Mon, May 24, 2010 at 7:01 PM, Daniel Mack <daniel@caiaq.de> wrote:
> >> +config MACH_COLIBRI_PXA270_INCOME
> >> + ? ? bool "Income s.r.o. PXA270 SBC"
> >> + ? ? depends on MACH_COLIBRI
> >> + ? ? select PXA27x
> >> + ? ? select HAVE_PWM
> >> + ? ? select PXA_HAVE_BOARD_IRQS
> >
> > Hmm, now that we depend on MACH_COLIBRI, I think these auto-selects can
> > go away as MACH_COLIBRI already cares for them, right?
> >
> 
> Indeed. And if this income could be only used on colibri 270, I'd like to see
> the naming be consistent with colibri-pxa270-evalboard.c. (though honestly,
> I don't quite like a name to be that long)

Would you like to come up with a better one :) If you want, you could
just amend the patch and commit it as you wish, or just let me know how
you'd like it and I repost.

Thanks,
Daniel
