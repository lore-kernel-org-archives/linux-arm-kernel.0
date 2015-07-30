From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 29 Jul 2015 18:02:55 -0700
Subject: [PATCH 02/20] Documentation: watchdog: at91sam9_wdt: add clocks
 property
In-Reply-To: <1438215726-27452-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438215726-27452-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55B977BF.60000@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2015 05:21 PM, Alexandre Belloni wrote:
> The watchdog has an input clock, the slow clock. It is required as it will
> not function without it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
