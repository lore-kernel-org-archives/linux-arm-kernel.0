From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Dec 2010 12:18:31 -0800
Subject: [PATCH 0/2] Add 104MHz support for OMAP OneNAND
In-Reply-To: <20101221194433.3127.74744.sendpatchset@ahunter-work.research.nokia.com>
References: <20101221194433.3127.74744.sendpatchset@ahunter-work.research.nokia.com>
Message-ID: <20101221201831.GI5829@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adrian Hunter <adrian.hunter@nokia.com> [101221 11:44]:
> Hi
> 
> Here is OMAP2/3: OneNAND: add 104MHz support.
> 
> Adrian Hunter (2):
>       OMAP2/3: GPMC: put sync_clk value in picoseconds instead of nanoseconds
>       OMAP2/3: OneNAND: add 104MHz support

Gave these a quick try and the GPMC changes work fine for smc91x
on 2430sdp and tusb6010 g_ether for n810.  So I'll queue these,
thanks.

Tony
