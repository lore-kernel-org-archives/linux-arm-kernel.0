From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 26 Jan 2013 09:54:14 -0800
Subject: [PATCH 09/13] ARM: spear: make clock driver independent of headers
In-Reply-To: <1359156956-32404-10-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
 <1359156956-32404-10-git-send-email-arnd@arndb.de>
Message-ID: <20130126175414.10623.79451@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Arnd Bergmann (2013-01-25 15:35:52)
> Device drivers should not access MMIO registers through hardcoded
> platform specific address constants. Instead, we can pass the
> MMIO token to the spear clock driver in the initialization routine
> to contain that knowledge in the platform code itself.
> 
> Ideally, the clock driver would use of_iomap() or similar to
> get the address, and that can be used later, but for now, this
> is the minimal change.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

This change appears good to me (but needs testing).

Regards,
Mike
