From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 15:21:35 +0100
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
Message-ID: <201401171521.35940.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 January 2014, Hanjun Guo wrote:
> 
> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> 
> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
> name from the ACPI timer table is matched with all the registered
> timer controllers and matching initialisation routine is invoked.

I wouldn't anticipate this infrastructure to be required. Shouldn't all
ARMv8 machines have an architected timer?

	Arnd
