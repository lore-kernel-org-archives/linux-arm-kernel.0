From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 01 Oct 2010 19:06:00 +0200
Subject: [PATCH 2/2] rtc: use __devinit instead on pxa-rtc
In-Reply-To: <1285754535-30802-2-git-send-email-haojian.zhuang@marvell.com>
	(Haojian Zhuang's message of "Wed\, 29 Sep 2010 18\:02\:15 +0800")
References: <1285754535-30802-1-git-send-email-haojian.zhuang@marvell.com>
	<1285754535-30802-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <87k4m1onbb.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@marvell.com> writes:

> Avoid to use __init/__exit on probe()/remove(). Use __devinit/__devexit
> instead.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
