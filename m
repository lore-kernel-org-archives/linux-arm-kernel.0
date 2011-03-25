From: khilman@ti.com (Kevin Hilman)
Date: Fri, 25 Mar 2011 07:51:58 -0700
Subject: [PATCH 2/6] arm: mach-omap2: smartreflex: fix sr_late_init()
	error path in probe
In-Reply-To: <4D8C1111.7030807@ti.com> (Nishanth Menon's message of "Fri, 25
	Mar 2011 09:20:41 +0530")
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
	<1300984535-10530-2-git-send-email-aaro.koskinen@nokia.com>
	<87fwqczbba.fsf@ti.com> <4D8C1111.7030807@ti.com>
Message-ID: <87bp0zw8vl.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman wrote, on 03/24/2011 10:48 PM:
>> Also, I renamed the subject/shortlog to use 'OMAP2+: smartreflex: ..."
>> instead of 'arm: mach-omap2'.
>
> might be better to be OMAP3+ we dont have SR on OMAP2 :)
>

Good point.  Will use OMAP3+.

Thanks,

Kevin

P.S. Nishanth, as you are one of the primary developers on SR, any
     acks, reviewed-bys from you are most welcome on SR patches.
     Thanks.
