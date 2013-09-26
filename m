From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 26 Sep 2013 08:07:31 -0500
Subject: [PATCH 21/26] ARM: socfpga: remove custom .init_time hook
In-Reply-To: <1379526839-14798-22-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-22-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1380200851.12204.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-09-18 at 19:53 +0200, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove custom .init_time hooks.
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
>  arch/arm/mach-socfpga/socfpga.c |    9 ---------
>  1 file changed, 9 deletions(-)
> 

Acked-by: Dinh Nguyen <dinguyen@altera.com>

Thanks,
Dinh
