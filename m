From: Jiri.Pinkava@vscht.cz (=?ISO-8859-2?Q?Ji=F8=ED_Pinkava?=)
Date: Mon, 4 Oct 2010 02:23:11 +0200
Subject: [PATCH 0/6] - Acer n35 fixes and features
Message-ID: <4CA91E6F.3010704@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fix some minor bugs on Acer n35 and add new features:

   * fix invalid key codes (typing error)
   * Replace hardcoded numbers by named constants in UART configuration
   * Fix MMC power management
   * Add touchscreen support
   * Add LCD backlight regulation
