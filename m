From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 16 Dec 2013 15:56:13 -0800
Subject: [PATCHv5] rtc: Add support for Intersil ISL12057 I2C RTC chip
In-Reply-To: <bb04b9b4d76e735526ccc8e72df27a3ca894b4ca.1387235949.git.arno@natisbad.org>
References: <bb04b9b4d76e735526ccc8e72df27a3ca894b4ca.1387235949.git.arno@natisbad.org>
Message-ID: <20131216235613.GA12307@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 12:39:22AM +0100, Arnaud Ebalard wrote:
> 
> Intersil ISL12057 I2C RTC chip also supports two alarms. This patch
> only adds support for basic RTC functionalities (i.e. getting and
> setting time). Tests have been performed on NETGEAR ReadyNAS 102 w/
> startup/shutdown scripts, hwclock, ntpdate and openntpd.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
