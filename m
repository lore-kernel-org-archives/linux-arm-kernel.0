From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 05 Oct 2010 15:00:21 +0400
Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
In-Reply-To: <alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>	<20101001213532.1408.55832.stgit@twilight.localdomain>	<4CA999AA.4030608@ti.com>
	<alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com>
Message-ID: <4CAB0545.5060309@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-10-2010 23:15, Paul Walmsley wrote:

>>> --- /dev/null
>>> +++ b/arch/arm/plat-omap/32ksynctimer.c
>>> @@ -0,0 +1,184 @@
>>> +/*
>>> + * linux/arch/arm/plat-omap/clocksource.c

>> What name do you want to use? 32ksynctimer.c or clocksource.c?

> Thanks, that's a bug.

    And also note that filenames in heading comments have been long discouraged.

WBR, Sergei
