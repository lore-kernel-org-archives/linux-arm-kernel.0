From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 9 Mar 2015 08:33:31 -0700
Subject: [v4,3/9] watchdog: at91rm9200: use the system timer syscon
In-Reply-To: <1425570594-13124-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425570594-13124-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150309153331.GA7875@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 04:49:48PM +0100, Alexandre Belloni wrote:
> Use a syscon regmap to access the system timer registers.
> 
> Also, rename the driver atmel_st_watchdog to stop conflicting with
> at91sam9_wdt.c
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
