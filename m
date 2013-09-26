From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 26 Sep 2013 08:06:37 -0500
Subject: [PATCH 05/26] ARM: socfgpa: prepare for arch-wide .init_time
 callback
In-Reply-To: <1379526839-14798-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1380200797.12204.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-09-18 at 19:53 +0200, Sebastian Hesselbarth wrote:
> Current socfpga board init calls of_clk_init() from .machine_init. To
> allow consolidation of DT driven .time_init, move of_clock_init() to
> a temporary .time_init that will be removed when arch-wide callback is
> available.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-socfpga/socfpga.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Acked-by: Dinh Nguyen <dinguyen@altera.com>

Thanks,
Dinh
