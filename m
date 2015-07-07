From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 7 Jul 2015 19:02:54 +0200
Subject: [PATCH] pinctrl: at91: fix null pointer dereference
In-Reply-To: <1435853202-1632-1-git-send-email-davidcdueck@googlemail.com>
References: <1435853202-1632-1-git-send-email-davidcdueck@googlemail.com>
Message-ID: <20150707170254.GI3127@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2015 at 18:06:42 +0200, David Dueck wrote :
> Not all gpio banks are necessarily enabled, in the current code this can
> lead to null pointer dereferences.
> 

[...]

> 
> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: Ludovic Desroches <ludovic.desroches@atmel.com>
> CC: Boris Brezillon <boris.brezillon@free-electrons.com>
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-kernel at vger.kernel.org
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
