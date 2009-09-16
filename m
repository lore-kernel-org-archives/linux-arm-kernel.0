From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 16 Sep 2009 23:01:04 +0100
Subject: Problems with pthread on ARM/PXA270
In-Reply-To: <200909160926.02036.schindele@nentec.de>
References: <200909160926.02036.schindele@nentec.de>
Message-ID: <20090916220104.GD6243@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juergen Schindele wrote:
> But on our pxa270 platform the thread switch does not (or really
> rarely) happen and only one thread is printing always the same
> values. So i suppose thread switching is not working!

What time quantum does sched_rr_get_interval() return?  SCHED_RR is
only expected to switch that often.

-- Jamie
