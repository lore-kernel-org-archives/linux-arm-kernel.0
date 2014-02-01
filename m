From: marex@denx.de (Marek Vasut)
Date: Sat, 1 Feb 2014 23:56:45 +0100
Subject: imx-drm: screen flickering
In-Reply-To: <20140130074526.GQ16215@pengutronix.de>
References: <CAH9NwWe673znThNPWRvOCyAU2o7M-oouHD7+1tyRcmWTeJ8YFw@mail.gmail.com>
 <201401291553.15040.marex@denx.de> <20140130074526.GQ16215@pengutronix.de>
Message-ID: <201402012356.45736.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 30, 2014 at 08:45:26 AM, Sascha Hauer wrote:
> On Wed, Jan 29, 2014 at 03:53:14PM +0100, Marek Vasut wrote:
> > On Wednesday, January 29, 2014 at 12:15:57 PM, Sascha Hauer wrote:
> > > Hi Christian,
> > > 
> > > On Tue, Jan 28, 2014 at 09:11:32AM +0100, Christian Gmeiner wrote:
> > > > Hi all.
> > > > 
> > > > From time to time it happens that my LVDS display is flickering (look
> > > > at scroll bar in the video).
> > > > https://drive.google.com/file/d/0B_fznDimUHVubWtvVFlMTkdBbUU/edit?usp
> > > > =sha ring
> > > > 
> > > > I really want to find the root cause of it, but I do not know where
> > > > to start. I can trigger this
> > > > sometimes after xscreensever "blanks" the screen and the screensafer
> > > > gets disabled
> > > > via user input.
> > > > 
> > > > Any hints?
> > > 
> > > Sorry, no idea. Philipp and me watched the video, but we both haven't
> > > seen something like this before.
> > 
> > Isn't it the clock polarity being inverted thing again [1]?
> 
> Could be, at least the result should look similar. I just wonder why it
> only happens after a few times doing something. I would expect the clock
> is always inverted then.

I actually noticed a rather strange behavior when the clock polarity was 
inverted as well. The flicker was not always there in my case either, but I used 
parallel LCD .

Best regards,
Marek Vasut
