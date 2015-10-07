From: dave@stgolabs.net (Davidlohr Bueso)
Date: Wed, 7 Oct 2015 07:36:58 -0700
Subject: [PATCH -tip] ARM: atomics: implement _relaxed variants of
 atomic[64]_{inc,dec}
In-Reply-To: <1444227038-12533-1-git-send-email-will.deacon@arm.com>
References: <1444227038-12533-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151007143658.GA3353@linux-uzut.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Oct 2015, Will Deacon wrote:

>Now that the core code supports acquire/release/relaxed versions of
>the atomic_inc family, implement only the _relaxed flavours in the ARM
>backend so that we get all of the others for free.
>
>Cc: Davidlohr Bueso <dbueso@suse.de>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks for following up with this!

Acked-by: Davidlohr Bueso <dbueso@suse.de>
