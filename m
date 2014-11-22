From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 16:31:54 -0800
Subject: [PATCH 05/10] arm: omap: omap2plus_defconfig: enable ECAP and
 EHRPWM
In-Reply-To: <1416334028-7766-5-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
 <1416334028-7766-5-git-send-email-balbi@ti.com>
Message-ID: <20141122003154.GL7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141118 10:08]:
> Many of AM335x and AM437x hook backlight to
> one of these two devices. By enabling their
> drivers we make sure pwm-backlight can do
> its thing.

Applying patches 1 - 5 to omap-for-v3.19/soc thanks.

Tony
