From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 7 Oct 2015 16:16:19 +0200
Subject: [PATCH -tip] ARM: atomics: implement _relaxed variants of
 atomic[64]_{inc,dec}
In-Reply-To: <1444227038-12533-1-git-send-email-will.deacon@arm.com>
References: <1444227038-12533-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151007141619.GH3816@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 03:10:38PM +0100, Will Deacon wrote:
> Now that the core code supports acquire/release/relaxed versions of
> the atomic_inc family, implement only the _relaxed flavours in the ARM
> backend so that we get all of the others for free.
> 
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> This sits on top of tip/locking/core and it would be great to have it
> queued there.

Thanks!
