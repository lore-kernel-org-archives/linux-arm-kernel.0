From: mingo@elte.hu (Ingo Molnar)
Date: Mon, 28 Dec 2009 08:57:48 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <200912221751.39662.jpihet@mvista.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<20091221124318.GC4097@wear.picochip.com>
	<200912211435.05094.jpihet@mvista.com>
	<200912221751.39662.jpihet@mvista.com>
Message-ID: <20091228075748.GC20039@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Jean Pihet <jpihet@mvista.com> wrote:

> The code is for review, it has been checked, compiled and boot tested on 
> OMAP3 (Cortex-A8). Unfortunately I am still facing some cross compilation 
> problems of the tools/perf utility.

Have you managed to solve these cross-compilation problems? If yes, it would 
be nice to merge the fixes into upstream perf.

	Ingo
