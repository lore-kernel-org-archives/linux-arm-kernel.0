From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 13 May 2010 11:35:18 +0200
Subject: [PATCH 2/2] pxa/income: Add Income SBC support
In-Reply-To: <201005130646.32880.marek.vasut@gmail.com>
References: <1273628122-24635-1-git-send-email-marek.vasut@gmail.com>
	<1273628122-24635-2-git-send-email-marek.vasut@gmail.com>
	<20100512073420.GN30801@buzzloop.caiaq.de>
	<201005130646.32880.marek.vasut@gmail.com>
Message-ID: <20100513093518.GF30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 06:46:32AM +0200, Marek Vasut wrote:
> Dne St 12. kv?tna 2010 09:34:20 Daniel Mack napsal(a):
> > On Wed, May 12, 2010 at 03:35:22AM +0200, Marek Vasut wrote:
> > > This is support for custom design based on Toradex Colibri PXA270 CPU
> > > card. Initial patch was by Pavel Revak.
> >
> > Hmm, so this is exactly what a module/board split would make sense for
> > now, as this patch duplicates tons of lines from one file to another.
> >
> > Marek, what do you think - is it worth giving that approach a try?
>
> I replied from the cellphone,but it probably didn't arrive. Anyway, I'm all for
> it. Should be do it after or before this goes in ?

I would rather not commit the support as it is right now, mainly because
with the new aproach of separated module and board code, there will be
need for another boot parameter. Things get too confusing if they're
changed too often.

The split should be easy though.

Daniel
