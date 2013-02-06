From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Feb 2013 09:00:26 +0000
Subject: [PATCH V3 1/5] DMA: PL330: Add new pl330 filter for DT case.
In-Reply-To: <1360131529-2847-2-git-send-email-padma.v@samsung.com>
References: <1360131529-2847-1-git-send-email-padma.v@samsung.com>
 <1360131529-2847-2-git-send-email-padma.v@samsung.com>
Message-ID: <201302060900.26986.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 February 2013, Padmavathi Venna wrote:
> 
> This patch adds a new pl330_dt_filter for DT case to filter the
> required channel based on the new filter params and modifies the
> old filter only for non-DT case as suggested by Arnd Bergmann.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
