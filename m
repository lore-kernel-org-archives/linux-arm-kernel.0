From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 30 Jan 2014 08:45:26 +0100
Subject: imx-drm: screen flickering
In-Reply-To: <201401291553.15040.marex@denx.de>
References: <CAH9NwWe673znThNPWRvOCyAU2o7M-oouHD7+1tyRcmWTeJ8YFw@mail.gmail.com>
 <20140129111557.GI16215@pengutronix.de>
 <201401291553.15040.marex@denx.de>
Message-ID: <20140130074526.GQ16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 03:53:14PM +0100, Marek Vasut wrote:
> On Wednesday, January 29, 2014 at 12:15:57 PM, Sascha Hauer wrote:
> > Hi Christian,
> > 
> > On Tue, Jan 28, 2014 at 09:11:32AM +0100, Christian Gmeiner wrote:
> > > Hi all.
> > > 
> > > From time to time it happens that my LVDS display is flickering (look
> > > at scroll bar in the video).
> > > https://drive.google.com/file/d/0B_fznDimUHVubWtvVFlMTkdBbUU/edit?usp=sha
> > > ring
> > > 
> > > I really want to find the root cause of it, but I do not know where to
> > > start. I can trigger this
> > > sometimes after xscreensever "blanks" the screen and the screensafer
> > > gets disabled
> > > via user input.
> > > 
> > > Any hints?
> > 
> > Sorry, no idea. Philipp and me watched the video, but we both haven't
> > seen something like this before.
> 
> Isn't it the clock polarity being inverted thing again [1]?

Could be, at least the result should look similar. I just wonder why it
only happens after a few times doing something. I would expect the clock
is always inverted then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
