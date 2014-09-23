From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 14:57:37 +0200
Subject: [PATCH v8 00/10] rtc: at91sam9: add DT support
In-Reply-To: <1411471444-2764-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1411471444-2764-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <2804695.hx0ZOj3D5K@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 13:23:54 Boris BREZILLON wrote:
> 
> This patch series adds DT support to the atmel at91sam9 RTC driver.
> 
> It also removes any machine specific inclusions to prepare the migration
> to multi platform kernel support, and retain the slow clock to prevent
> the CCF from disabling it at the end of boot.
>   
> 

Looks good to me, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

once you have addressed the remaining comments from Johan and me.

	Arnd
