From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 26 Oct 2016 12:53:20 -0700
Subject: [PATCH 0/5] Minimal cpuidle fixes for omap5 and dra7
In-Reply-To: <20161026151703.24730-1-tony@atomide.com>
References: <20161026151703.24730-1-tony@atomide.com>
Message-ID: <ecf2d8f9-c385-26db-7ffd-49026ecbc380@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/26/2016 8:16 AM, Tony Lindgren wrote:
> Hi all,
>
> Here are some fixes to get minimal cpuidle support working with omap5
> and dra7. Not sure if there are still some unsorted issues on enabling
> this on dra7, but at least omap5 has been behving for me for few
> weeks with these.
>
> Regards,
>
> Tony
>
>
> Santosh Shilimkar (1):
>   ARM: DRA7: PM: cpuidle MPU CSWR support
>
> Tony Lindgren (4):
>   ARM: OMAP5: Fix build for PM code
>   ARM: OMAP5: Fix mpuss_early_init
>   ARM: OMAP4+: Fix bad fallthrough for cpuidle
>   ARM: OMAP5: Enable minimal cpuidle for omap5 retention
>
Feel free to add my ack if you need one.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
