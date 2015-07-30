From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 29 Jul 2015 18:03:38 -0700
Subject: [PATCH 15/20] watchdog: at91sam9: get and use slow clock
In-Reply-To: <1438215726-27452-16-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438215726-27452-16-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55B977EA.3070500@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2015 05:22 PM, Alexandre Belloni wrote:
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
>
> Get and use the slow clock as it is necessary for the at91sam9 watchdog.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
