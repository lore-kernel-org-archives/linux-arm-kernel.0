From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 Apr 2016 15:41:41 -0700
Subject: [PATCH] extcon: usb-gpio: switch to use pm wakeirq apis
In-Reply-To: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
References: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20160406224141.GI16484@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160406 10:33]:
> Switch to use PM wakeirq APIs which automates wakeup IRQs
> enabling/disabling and so allows to make code simpler.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
