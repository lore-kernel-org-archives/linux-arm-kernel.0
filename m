From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 25 May 2011 18:06:16 +0200 (CEST)
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <20110525153459.GE27250@atomide.com>
References: <201105181047.17309.arnd@arndb.de>
	<BANLkTi=xzrLhHTBynWf4huA9EusfaDwPbA@mail.gmail.com>
	<20110525075902.GH30799@atomide.com>
	<alpine.LFD.2.00.1105251021550.3207@xanadu.home>
	<20110525153459.GE27250@atomide.com>
Message-ID: <alpine.LFD.2.02.1105251803120.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 May 2011, Tony Lindgren wrote:
> * Nicolas Pitre <nico@fluxnic.net> [110525 07:24]:
> > 
> > No.  We'll start merging stuff once this merge window is over.  In other 
> > words, you are still on your own for the current one.
> 
> OK
>  
> > Also, I want stuff merged in this subarch tree way before the next merge 
> > window opens on a continuous basis, not in a big rush before it opens, 
> > or worse, while it is already open.
> 
> OK that sounds good to me. There's at least one more thing to sort out
> though:
> 
> What do you want to do with with the various for-next branches?
> 
> Do you want to queue things into your tree before hitting for-next?

The stuff which gets pulled in from the various suppliers is
aggregated in a separate for -next branch.

Thanks,

	tglx
