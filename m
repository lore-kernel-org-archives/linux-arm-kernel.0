From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 May 2011 13:39:10 -0700
Subject: [PATCH] OMAP: don't trace functions called from sched_clock
In-Reply-To: <1304846514-15641-1-git-send-email-rabin@rab.in> (Rabin Vincent's
	message of "Sun, 8 May 2011 14:51:54 +0530")
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
Message-ID: <87hb8fyj2p.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin Vincent <rabin@rab.in> writes:

> omap_readl() is used from the sched_clock() implementations and so must
> be marked notrace to avoid recursion in ftrace.  Same thing with
> mpu_read() for OMAP1.
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Acked-by: Kevin Hilman <khilman@ti.com>
