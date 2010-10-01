From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 01 Oct 2010 19:03:59 +0200
Subject: [PATCH 1/2] rtc: avoid checking cpuid in pxa-rtc
In-Reply-To: <1285754535-30802-1-git-send-email-haojian.zhuang@marvell.com>
	(Haojian Zhuang's message of "Wed\, 29 Sep 2010 18\:02\:14 +0800")
References: <1285754535-30802-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <87ocbdoneo.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@marvell.com> writes:

> pxa-rtc is widely used in pxa27x/pxa3xx/pxa93x/pxa95x. Checking cpuid in
> pxa-rtc driver is unnecessary since we assign on-chip device in soc files.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
