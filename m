From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Dec 2009 22:42:41 +0100
Subject: HTC Dream: mmc compilation fixes
In-Reply-To: <1260305123.11826.25.camel@c-dwalke-linux.qualcomm.com>
References: <20091206195953.GA26863@elf.ucw.cz>
	<1260305123.11826.25.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20091208214241.GB4164@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2009-12-08 12:45:22, Daniel Walker wrote:
> On Sun, 2009-12-06 at 20:59 +0100, Pavel Machek wrote:
> > +
> > +struct embedded_sdio_data {
> > +        struct sdio_cis cis;
> > +        struct sdio_cccr cccr;
> > +        struct sdio_embedded_func *funcs;
> > +        int num_funcs;
> > +};
> 
> 
> There's some indentation problems in this block, I'll fix it prior to
> merging it..

Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
