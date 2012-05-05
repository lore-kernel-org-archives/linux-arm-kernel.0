From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 5 May 2012 10:09:36 +0200
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <201205041624.17850.arnd@arndb.de>
References: <201205031350.35476.arnd@arndb.de>
 <20120503144609.GK4141@pengutronix.de>
 <201205041624.17850.arnd@arndb.de>
Message-ID: <20120505080936.GP4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 04:24:17PM +0000, Arnd Bergmann wrote:
> On Thursday 03 May 2012, Sascha Hauer wrote:
> > I don't think that enforcing DT only in multiplatform kernels will speed
> > up porting to DT. As a platform maintainer I am interested in building
> > multiplatform Kernels, but our customers are mostly uninterested in
> > this. They probably disable other platforms anyway to save the binary space.
> 
> I was not asking about enabling multiple board files but multiple mach-*
> directories, 

Yes, I understood that.

> which is something that I'm probably more interested in than
> you are, and the customers you refer to would certainly not do that if
> they only want to run on one board.
> 
> This is really about people who distribute kernels that run on a wide
> variety of machines across soc vendor boundaries, people like
> ubuntu or cyanogenmod. The question is really whether you see a reason
> why they should enable the 25 non-DT board files on your platform, rather
> than helping out getting DT support for the machines they are
> interested in?

They should not if they are not interested in these boards, but why
shouldn't I be able to enable these 25 boards plus a few atmel or pxa
boards?

When there are technical reasons to limit a multiplatform Kernel to DT
only, then fine, lets do it that way. If there are no technical reasons
and this limitation shall only be used to put some political pressure on
platform board maintainers, then I am against it. Look around, people
actually *are* porting their boards over to device tree, I don't think
that such pressure is necessary.

Only my two cents, it's not that important to me since I want to port my
(relevant) boards over to DT anyway, so I won't argue about this.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
