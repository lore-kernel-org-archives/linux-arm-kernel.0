From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 May 2013 19:12:53 +0200
Subject: [PATCHv4 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
In-Reply-To: <201305241910.37975.arnd@arndb.de>
References: <1369410080-436-1-git-send-email-dinguyen@altera.com>
 <1369410080-436-6-git-send-email-dinguyen@altera.com>
 <201305241910.37975.arnd@arndb.de>
Message-ID: <201305241912.53751.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 May 2013, Arnd Bergmann wrote:

> It also seems odd to have this in the series for the ethernet driver.

After I sent it I realized that your patches are actually for different
parts of the system, they were just all replies to the same first patch.

It's usually helpful to add a [PATCH 0/6] message that explains the
overall intention and who you expect to pick up the patches, to avoid
the confusion I had.

	Arnd
