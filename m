From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Jun 2016 02:53:05 -0700
Subject: [PATCH 0/4] Get kexec working on SMP omap variants
In-Reply-To: <cfc75c15-ab10-22ee-35b8-529e28d2773c@oracle.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
 <cfc75c15-ab10-22ee-35b8-529e28d2773c@oracle.com>
Message-ID: <20160622095303.GF22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@oracle.com> [160621 09:10]:
> 
> I suggest to do bit wider testing including PM. From
> quick scan, the series looks fine to me.

Looks like the /sys/kernel/debug/pm_debug/count values for
both cores for off increse just fine with these patches
both before and after kexec.

> FWIW, Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Thanks,

Tony
