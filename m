From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 4 Jun 2013 09:39:27 +0000
Subject: [PATCH 2/2] rtc: omap: add rtc wakeup support to alarm events
In-Reply-To: <87a9nb2gjh.fsf@linaro.org>
References: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
 <1369982005-8572-3-git-send-email-gururaja.hebbar@ti.com>
 <87a9nb2gjh.fsf@linaro.org>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC222D4@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 23:11:22, Kevin Hilman wrote:
> Hebbar Gururaja <gururaja.hebbar@ti.com> writes:
> 
> > On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
> > is available to enable Wakeup feature for Alarm Events.
> >
> > Since new platforms/Boards are now added through DT only, this feature
> > is supported via DT property only.
> 
> > Platforms using such IP should add the property "ti,has_irq_wake_enb"
> > in rtc DT node.
> 
> This is a property of the IP, not the board.  

Correct.

> Can't you detect this
> based on the revision of the IP?

Will check this and return.

> 
> Kevin
> 


Regards, 
Gururaja
