From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Jul 2015 21:32:38 +0200
Subject: [PATCH v2] watchdog: sunxi: fix activation of system reset
In-Reply-To: <55B32BCE.5050506@gmail.com>
References: <55B32BCE.5050506@gmail.com>
Message-ID: <20150726193238.GM2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 25, 2015 at 08:25:18AM +0200, Francesco Lavra wrote:
> Commit f2147de33470 ("watchdog: sunxi: support parameterized compatible
> strings") introduced a regression in sunxi_wdt_start(), by which
> the system reset function of the watchdog is not enabled upon
> starting the watchdog. As a result, the system is not reset when the
> watchdog expires. Fix it. 
> 
> Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: f2147de33470 ("watchdog: sunxi: support parameterized compatible strings")
> Cc: stable at vger.kernel.org

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150726/a7d3ce57/attachment.sig>
