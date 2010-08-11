From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 11 Aug 2010 11:45:43 +0200
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <201008111107.29839.marek.vasut@gmail.com>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
	<201008111042.52631.marek.vasut@gmail.com>
	<AANLkTimL7kt0-Do9VQUQvktHfsvdKjm_NJ-eDbxcAu2m@mail.gmail.com>
	<201008111107.29839.marek.vasut@gmail.com>
Message-ID: <20100811094543.GO17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 11:07:29AM +0200, Marek Vasut wrote:
> Dne St 11. srpna 2010 10:54:08 Yuri Ludkevich napsal(a):
> > 2010/8/11 Marek Vasut <marek.vasut@gmail.com>
> > 
> > > Dne St 11. srpna 2010 09:43:30 Yuri Ludkevich napsal(a):
> > > 
> > > Hi, it looks like the IRQ was misdetected probably. Check the following
> > > two patches (and possibly the vpac270 source file, the "Audio and
> > > Touchscreen" section will give you an idea how to force IRQ line to the
> > > driver).
> > 
> > BTW do you know which GPIO used for UCB1400 interrupt?

According to my reverse engineering, this should be GPIO4_2.


Daniel
