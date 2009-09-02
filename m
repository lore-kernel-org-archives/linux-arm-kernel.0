From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 2 Sep 2009 19:50:47 +0200
Subject: AC97 on  i.MX27
In-Reply-To: <OF744AA145.8166D38C-ONC1257625.0041CD11-C1257625.0041F924@phytec.de>
References: <OF744AA145.8166D38C-ONC1257625.0041CD11-C1257625.0041F924@phytec.de>
Message-ID: <20090902175046.GB3249@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 01:59:50PM +0200, Jan Weitzel wrote:
> Hello, 
> I am trying to get an Wolfson WM9712L working with AC97 on a i.MX27. I saw 
> some patches for 2.6.22 on the list. Does anybody have further worked on 
> this, or is it a good point to start from? 

Well, I've got it working with a UCB1400 codec/touch controller on a
Garz&Fricke Neso board. But that's a bunch of patches on top of that
dungheap of a Freescale queue. Really not worth posting that. It's
basically Lothar's version with two or three fixes, mostly touchscreen
related (we never used it for audio).

So yes, Lothar's patch is a good starting point. You might also have a
look at Sascha's git tree, maybe he picked something up.

Thanks,
Hans
