From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 25 May 2018 22:22:47 +0200
Subject: [PATCH] ARM: pxa3xx: enable external wakeup pins
In-Reply-To: <20180524204046.21494-1-daniel@zonque.org> (Daniel Mack's message
 of "Thu, 24 May 2018 22:40:46 +0200")
References: <20180524204046.21494-1-daniel@zonque.org>
Message-ID: <87in7bwkmg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> The PXA3xx SoCs feature dedicated pins for wakeup functionality. These pins
> have no alternate functions, so let's always enable them as wakeup source on
> DT enabled boards. The WAKEUP1 pin is only available on PXA320.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
That looks correct. Is it tested on any board ?

Cheers.

--
Robert
