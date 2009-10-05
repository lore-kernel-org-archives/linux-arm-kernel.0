From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 05 Oct 2009 10:57:10 -0700
Subject: [PATCH 0/5] OMAP PM fixes for 2.6.32
In-Reply-To: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
	(Kevin Hilman's message of "Fri\, 2 Oct 2009 11\:14\:50 -0700")
References: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <877hv9yb9l.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> These fixes are primarily for PRCM interrupt handler bugs
> and GPIO wakeup support.
>
> Jon Hunter (1):
>   OMAP3: PM: Prevent hang in prcm_interrupt_handler
>
> Kevin Hilman (1):
>   OMAP3: PM: Enable GPIO module-level wakeups
>
> Paul Walmsley (2):
>   OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
>   OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts
>
> Vikram Pandita (1):
>   OMAP3: PM: USBHOST: clear wakeup events on both hosts
>

Here's one more for the PM fixes queue from Atrem.

Kevin
