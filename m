From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2016 00:28:29 +0200
Subject: [PATCH 1/2] ARM: multi_v5_defconfig: Enable support for MX21/MX27
In-Reply-To: <1458991706-30109-1-git-send-email-jlu@pengutronix.de>
References: <1458991706-30109-1-git-send-email-jlu@pengutronix.de>
Message-ID: <3101569.yyK0A7ozKe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 March 2016 12:28:25 Jan Luebbe wrote:
> Although the SoC support was already enabled, the drivers and machines
> were missing.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> 

I thought about applying this to the bug fix branch for 4.6, but
it doesn't seem urgent enough for that. Unless there is something
I'm missing about why we need it now, please have these merged
by the i.MX maintainers and sent to our next/defconfig branch for 4.7.

	Arnd
