From: sr@denx.de (Stefan Roese)
Date: Fri, 16 Mar 2012 13:57:05 +0100
Subject: [PATCH v4] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <201203161252.54953.arnd@arndb.de>
References: <1331890216-8361-1-git-send-email-sr@denx.de>
 <201203161333.22524.sr@denx.de> <201203161252.54953.arnd@arndb.de>
Message-ID: <201203161357.06146.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012 13:52:54 Arnd Bergmann wrote:
> On Friday 16 March 2012, Stefan Roese wrote:
> > > I actually like to see the devices in there, and it already helped
> > > figure out that there are two buses instead of just one. Maybe we
> > > can agree on putting them in the file but commenting them out using
> > > /* */ with an added notice that they will get enabled once we have
> > > bindings?
> > 
> > It would be great to have a decision on this. I'm leaving for a short
> > vacation in a few hours and would like to have the new (hopefully final)
> > patch out before that.
> 
> It's not a show-stopper for me either way, your patches look great.

Thanks Arnd.

I'll leave the devices included then, and still disabled. Stay tuned...

Thanks,
Stefan
