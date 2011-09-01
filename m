From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Sep 2011 20:22:01 +0200
Subject: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq
	handlers
In-Reply-To: <1314900722-10252-1-git-send-email-khilman@ti.com>
References: <1314900722-10252-1-git-send-email-khilman@ti.com>
Message-ID: <1876183.c78P8V3ZbL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 September 2011 11:12:02 Kevin Hilman wrote:
> The suspend/resume _noirq handlers were #ifdef'd out in the
> !CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
> struct.  Fix by defining them to NULL in the !CONFIG_SUSPEND case.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thansk for the fast response!
