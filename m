From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Oct 2015 15:52:55 -0700
Subject: [PATCH] ARM: dts: Use defined GPIO constants in flags cell for
 OMAP2+ boards
In-Reply-To: <1444122219-30419-1-git-send-email-javier@osg.samsung.com>
References: <1444122219-30419-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20151012225255.GL23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@osg.samsung.com> [151006 02:08]:
> Many OMAP2+ DTS are not using the defined constants to express
> the GPIO polarity. Replace these so the DTS are easier to read.


Applying this into omap-for-v4.4/dt thanks.

Tony
