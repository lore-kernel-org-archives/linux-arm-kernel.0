From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 31 May 2013 10:41:22 -0700
Subject: [PATCH 2/2] rtc: omap: add rtc wakeup support to alarm events
In-Reply-To: <1369982005-8572-3-git-send-email-gururaja.hebbar@ti.com> (Hebbar
 Gururaja's message of "Fri, 31 May 2013 12:03:25 +0530")
References: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
 <1369982005-8572-3-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <87a9nb2gjh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
> is available to enable Wakeup feature for Alarm Events.
>
> Since new platforms/Boards are now added through DT only, this feature
> is supported via DT property only.

> Platforms using such IP should add the property "ti,has_irq_wake_enb"
> in rtc DT node.

This is a property of the IP, not the board.  Can't you detect this
based on the revision of the IP?

Kevin
