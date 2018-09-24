From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Sep 2018 15:06:30 -0700
Subject: [PATCH 3/3] ARM: OMAP2PLUS: Remove references to AM3517-EVM
 since it's in DT
In-Reply-To: <20180923153718.15095-3-aford173@gmail.com>
References: <20180923153718.15095-1-aford173@gmail.com>
 <20180923153718.15095-3-aford173@gmail.com>
Message-ID: <20180924220630.GI5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam Ford <aford173@gmail.com> [180923 08:41]:
> Since the audio codecs used on the AM3517-EVM are now available
> in device tree, and the audio driver wasn't really being used
> anyway, this patch removes the remaining AM3517 legacy board
> options and sound soc drivers.

Mark do you want to pick this one? If so:

Acked-by: Tony Lindgren <tony@atomide.com>

Maybe update the subject line according too.

Regards,

Tony
