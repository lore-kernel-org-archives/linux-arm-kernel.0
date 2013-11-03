From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 03 Nov 2013 10:32:48 -0800
Subject: [PATCH 3/3] watchdog: at91sam9_wdt: increase security margin
 on watchdog counter reset
In-Reply-To: <1383501164-8111-4-git-send-email-b.brezillon@overkiz.com>
References: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
 <1383501164-8111-4-git-send-email-b.brezillon@overkiz.com>
Message-ID: <527696D0.9080705@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2013 09:52 AM, Boris BREZILLON wrote:
> Try to reset the watchdog counter 4 or 2 times more often than actually
> requested, to avoid spurious watchdog reset.
> If this is not possible because of the min_heartbeat value, reset it at
> the min_heartbeat period.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
