From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 11 Jul 2018 15:31:57 +0200
Subject: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
In-Reply-To: <20180711092555.268adf7f@gandalf.local.home>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
Message-ID: <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-11 09:25:55 [-0400], Steven Rostedt wrote:
> Did you decide to create a local_lock_bh(lock) function? I don't see it.
> 
> And should this be backported to 4.14-rt too? You state you saw this in
> 4.16-rt, but did you start doing something different then, or did the
> kernel change?

I wanted to re-evaluate the whole situation here but didn't get to it
yet.

> Thanks!
> 
> -- Steve

Sebastian
