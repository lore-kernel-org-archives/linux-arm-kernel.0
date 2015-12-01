From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 Dec 2015 18:45:58 +0530
Subject: [PATCH 3/7] ARM: davinci: make headers more local
In-Reply-To: <1448924458-3279040-4-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
 <1448924458-3279040-4-git-send-email-arnd@arndb.de>
Message-ID: <565D9D8E.9090807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 04:30 AM, Arnd Bergmann wrote:
> Some header files are never included outside of a mach-davinci
> directory and do not need to be made visible in include/mach,
> so let's just move them all down one level.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Boot tested this on DM644x EVM too.

Thanks,
Sekhar
