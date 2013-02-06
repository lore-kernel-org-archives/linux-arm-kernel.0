From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Feb 2013 09:00:45 +0000
Subject: [PATCH V3 5/5] ARM: SAMSUNG: dma: Remove unnecessary code
In-Reply-To: <1360131529-2847-6-git-send-email-padma.v@samsung.com>
References: <1360131529-2847-1-git-send-email-padma.v@samsung.com>
 <1360131529-2847-6-git-send-email-padma.v@samsung.com>
Message-ID: <201302060900.45462.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 February 2013, Padmavathi Venna wrote:
> 
> This patch removes the usage of DMACH_DT_PROP and dt_dmach_prop
> from dma code as the new generic dma dt binding support has been
> added.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>


Acked-by: Arnd Bergmann <arnd@arndb.de>
