From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 18:00:22 -0700
Subject: [PATCH v16 12/12] OMAP: dmtimer: get rid of timer_ip_version field
In-Reply-To: <1316518227-28116-13-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-13-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110922010022.GQ2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> We do not need this field in dmtimer_platform_data{} anymore.
> Instead, read "tidr" register to identify the ip version now.

Let's wait a bit on this one as Benoit had some comments regarding
the use of tidr.

Regards,

Tony
