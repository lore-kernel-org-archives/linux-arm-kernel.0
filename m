From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 03 Nov 2013 10:06:49 -0800
Subject: [PATCH 1/3] watchdog: at91sam9_wdt: fix secs_to_ticks
In-Reply-To: <1383501164-8111-2-git-send-email-b.brezillon@overkiz.com>
References: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
 <1383501164-8111-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <527690B9.7010202@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2013 09:52 AM, Boris BREZILLON wrote:
> Fix the secs_to_ticks macro in case 0 is passed as an argument.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
