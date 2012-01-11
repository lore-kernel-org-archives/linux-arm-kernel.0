From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jan 2012 09:34:29 +0100
Subject: linux-next: please update the i.MX tree
In-Reply-To: <20120111093457.af3caeabe2dbf50b70942334@canb.auug.org.au>
References: <20120110115218.e00ab8c01abd5b9ae9a3b166@canb.auug.org.au>
 <20120110083020.GR5446@pengutronix.de>
 <20120111093457.af3caeabe2dbf50b70942334@canb.auug.org.au>
Message-ID: <20120111083429.GU5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 09:34:57AM +1100, Stephen Rothwell wrote:
> Hi Sascha,
> 
> On Tue, 10 Jan 2012 09:30:20 +0100 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > On Tue, Jan 10, 2012 at 11:52:18AM +1100, Stephen Rothwell wrote:
> > > 
> > > It looks like most (if not all) of the i.MX tree has been merged into the
> > > arm-soc (and Linus') tree, so could you please update the i.MX tree to
> > > eliminate the conflicts I am getting.
> > 
> > Did this. Sorry, I was not aware that there is something in this branch.
> 
> Did you push it out? I just checked and it hasn't changed. Just to be
> clear, I am fetching git://git.pengutronix.de/git/imx/linux-2.6.git
> branch for-next and it hasn't changed since last September.

I failed to wait until my push returned. It failed due to
non-fast-forward pushing. Really fixed this now.

> 
> Should I, instead, just remove that tree from linux-next and let you send
> stuff just via the arm-soc (or arm)tree?

Yes, that's probably best. That's what I do anyway.

Sascha



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
