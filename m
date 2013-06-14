From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jun 2013 16:30:08 +0200
Subject: [PATCH V2] arm: pj4: check cpu id for pj4 cp0 access
In-Reply-To: <1371200637-20850-1-git-send-email-chao.xie@marvell.com>
References: <1371200637-20850-1-git-send-email-chao.xie@marvell.com>
Message-ID: <201306141630.08849.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 June 2013, Chao Xie wrote:
> Check cpu id in pj4_cp0_init. So for no-PJ4 V7 cpus,
> pj4_cpu0_init just return.
> This fix will help to make the all the V7 cpus(pj4 and no-PJ4)
> use same platform code.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
