From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 13 Nov 2015 14:34:43 -0500 (EST)
Subject: [PATCH] clocksource: arm_global_timer: fix suspend resume
In-Reply-To: <5646369F.8040300@ti.com>
References: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com>
 <87a8qhq284.fsf@saruman.tx.rr.com> <56461688.1090809@ti.com>
 <87y4e1ol0g.fsf@saruman.tx.rr.com> <56462742.3020300@ti.com>
 <87si49ojed.fsf@saruman.tx.rr.com> <56462C0A.6070802@ti.com>
 <87mvuhoimr.fsf@saruman.tx.rr.com> <56463304.2040009@ti.com>
 <5646369F.8040300@ti.com>
Message-ID: <alpine.DEB.2.11.1511131431090.3987@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Nov 2015, Grygorii Strashko wrote:

<Delete 100 lines of useless information>

> Any way, I'll wait for other comments a bit, replace save/restore with
> just pure re-enabling and re-send.

Please folks, trim your emails! I'm really tired of going through
hundreds of quoted (quoting level here was 10!!!) useless lines to
find a single line of useful information. 

Thanks,

	tglx
