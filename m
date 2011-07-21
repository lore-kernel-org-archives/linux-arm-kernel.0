From: khilman@ti.com (Kevin Hilman)
Date: Thu, 21 Jul 2011 08:32:49 -0700
Subject: [PATCHV3 0/4] The series attempts to do the following
In-Reply-To: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Thu, 21 Jul 2011 19:22:57 +0530")
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <877h7babtq.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> - The reset should not be done in the driver 
>   have support for the same.
> - Remove the sysc register access in the driver.
> - Restore the context only if the context is lost.

Hello,

Can you base the next version of this on my wip/i2c branch[1] which has a
couple other misc. cleanup patches that will be queued for v3.2.

Thanks,

Kevin


[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git wip/i2c
