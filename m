From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 1 Feb 2011 16:34:54 +0100
Subject: [PATCH v4 1/4] drivers: hwspinlock: add framework
In-Reply-To: <1296470024-26854-2-git-send-email-ohad@wizery.com>
References: <1296470024-26854-1-git-send-email-ohad@wizery.com>
	<1296470024-26854-2-git-send-email-ohad@wizery.com>
Message-ID: <201102011634.54762.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 January 2011, Ohad Ben-Cohen wrote:
> Add a platform-independent hwspinlock framework.
> 
> Hardware spinlock devices are needed, e.g., in order to access data
> that is shared between remote processors, that otherwise have no
> alternative mechanism to accomplish synchronization and mutual exclusion
> operations.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Hari Kanigeri <h-kanigeri2@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Walmsley <paul@pwsan.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
