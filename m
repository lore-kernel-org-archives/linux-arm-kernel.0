From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Sep 2011 16:54:53 -0700
Subject: [PATCH v6 20/25] gpio/omap: skip operations in runtime callbacks
In-Reply-To: <1314798161-19523-21-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:36 +0530")
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-21-git-send-email-tarun.kanti@ti.com>
Message-ID: <87ty8pw7jm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Most operations within runtime callbacks should be skipped when
> *_runtime_get_sync() and *_runtime_put_sync() are called in probe(),
> *_gpio_request() and *_gpio_free(). 

Why?  

(again, I know the answer, but should be described in the changelog for
folks not familiar with this driver, or when we come back to this in 3
months and have forgotten why.

> We just need clock enable/disable.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Kevin
