From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 16 Mar 2012 14:11:29 +0100
Subject: [PATCH v5] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <1331903003-14045-1-git-send-email-sr@denx.de>
References: <1331903003-14045-1-git-send-email-sr@denx.de>
Message-ID: <20120316131129.GH7757@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:03 Fri 16 Mar     , Stefan Roese wrote:
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
> Since the current mainline SPEAr600 code only supports the SPEAr600
> evaluation board, with nearly zero peripheral devices (only UART
> and GPIO), it makes sense to switch over to DT based configuration
> completely now. So this patch also removes all non-DT stuff, mainly
> platform device data. The files spear600.c and spear600_evb.c are
> removed completely.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Acked-by: Viresh Kumar <viresh.kumar@st.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>


I'm not a fan to have non Documented DT binding butthey are basic so ok

Best Regards,
J.
