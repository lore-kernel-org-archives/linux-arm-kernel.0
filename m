From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Aug 2015 01:32:15 -0700
Subject: [PATCH-next 2/4] arm: boot: dts: am4372: add ARM timers and SCU
 nodes
In-Reply-To: <1439409416-32673-3-git-send-email-balbi@ti.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
 <1439409416-32673-3-git-send-email-balbi@ti.com>
Message-ID: <20150813083215.GY4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150812 13:00]:
> AM437x devices sport SCU, TWD and Global timers,
> let's add them to DTS so they have a chance to
> probe and be used by Linux.

Applying this one into omap-for-v4.3/dt-v2. Not sure
if it will get merged as we're getting close to the
merge window. The rest we can patch once Russell has
reverted the bogus SMP dependency.

Regards,

Tony
