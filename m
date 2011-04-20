From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 20 Apr 2011 19:42:21 +0400
Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
In-Reply-To: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <4DAEFEDD.1040106@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-04-2011 13:25, Shweta Gulati wrote:

> From: Gulati, Shweta<shweta.gulati@ti.com>

> Core Clk Tree shows incorrect Clk rates at OPP50, as
> in commit e07f469d284ca3d1f5dcf5438c22982be98bc071

    Please also specify that commit's summary -- for human readers.

> calling of 'recalc' in API clk_set_rate is unintentionally
> removed, because of which clock's tree rates get goofed
> up when DVFS happens. This Patch adds recalc API back.

> Tested on OMAP3630 SDP Board.

> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Cc: Paul Wamsley<paul@pwsan.com>

WBR, Sergei
