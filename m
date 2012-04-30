From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Apr 2012 08:29:19 -0600 (MDT)
Subject: [PATCH 3/6] ARM: OMAP4: hwmod: drop extra cpu_is check from
 _wait_target_disable()
In-Reply-To: <1335557140-10854-4-git-send-email-khilman@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
 <1335557140-10854-4-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1204300828560.10308@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Apr 2012, Kevin Hilman wrote:

> _omap4_wait_target_disable() is called only from inside _omap4_disable_module()
> which is already protected by SoC specific checks.  Remove the cpu_is check
> here.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Looks good to me.


- Paul
