From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 15:54:25 +0000
Subject: [PATCH v2] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <1331737232-25477-1-git-send-email-sr@denx.de>
References: <1331737232-25477-1-git-send-email-sr@denx.de>
Message-ID: <201203141554.25262.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Stefan Roese wrote:
> This patch adds a generic target for SPEAr600 board that can be
> configured via the device-tree. Currently the following devices
> are supported via the devicetree:
> 
> - VIC interrupts
> - PL011 UART
> - PL061 GPIO
> - Synopsys DW I2C
> - Synopsys DW ethernet
> 
> Other peripheral devices (e.g. SMI flash, FSMC NAND flash etc) will
> follow in later patches.
> 
> Only the spear600-evb is currently supported. Other SPEAr600
> based boards will follow later.
> 
> Additionally the file spear600.c is deleted. It contained only
> one empty function and is not needed. So lets just remove it.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Looks very good to me.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
