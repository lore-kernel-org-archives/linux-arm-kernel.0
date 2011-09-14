From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Sep 2011 09:45:00 -0400 (EDT)
Subject: [PATCH 4/6] ARM: zImage: gather some string functions into
	string.c
In-Reply-To: <20110914131314.GC2104@arm.com>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
	<1315978906-15829-5-git-send-email-nico@fluxnic.net>
	<20110914131314.GC2104@arm.com>
Message-ID: <alpine.LFD.2.00.1109140942250.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Sep 2011, Dave Martin wrote:

> Have you seen this?
> http://en.wikipedia.org/wiki/Duff%27s_device

Yeah... I did stumble across something similar in the gcc test suite.

> Once I finished vomiting, this actually struck be as rather neat.
> 
> If I've understood right, it seems a good fit for the manual unrolling
> you do here.

Maybe.  However this patch is about moving code, not "improving" it.  ;-)


Nicolas
