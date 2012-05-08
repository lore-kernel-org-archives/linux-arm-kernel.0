From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 15:42:31 -0700
Subject: [PATCH 1/2] input: keypad: move platform_data to
 <linux/platform_data>
In-Reply-To: <1331905159-11255-2-git-send-email-sourav.poddar@ti.com>
References: <1331905159-11255-1-git-send-email-sourav.poddar@ti.com>
 <1331905159-11255-2-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120508224230.GO5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sourav Poddar <sourav.poddar@ti.com> [120316 06:43]:
> From: Felipe Balbi <balbi@ti.com>
> 
> This patch allows us to drop the OMAP depencendy
> from the OMAP4 keypad driver.

Seems safe to apply via linux-input:

Acked-by: Tony Lindgren <tony@atomide.com>
