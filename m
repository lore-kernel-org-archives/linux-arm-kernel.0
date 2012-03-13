From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 13:09:21 +0000
Subject: [PATCH v8 0/4] USB: OHCI-HCD: Support for LPC32xx
In-Reply-To: <1331589292-18986-1-git-send-email-stigge@antcom.de>
References: <1331589292-18986-1-git-send-email-stigge@antcom.de>
Message-ID: <201203131309.21529.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012, Roland Stigge wrote:
> These patches add support for the LPC32xx to the ohci-pnx4008 driver and make
> the driver use smbus functions.
> 
> As discussed with Greg-KH on the USB mailing list, the ohci-pnx4008 driver is
> first renamed to reflect its multi-platform support. The second patch also
> renames the respective pnx4008_* symbols accordingly.
> 
> The third patch adds the actual lpc32xx support.
> 
> The fourth patch removes the re-coded i2c_write() by using an existing smbus
> function. You can leave out this very single patch to still have the desired
> LPC32xx support. It just fixes existing kernel code to only use smbus calls in
> this driver.
> 
> Applies to v3.3-rc7
> 
> Changes since v7:
> 
> * Removed pnx4008 filename reference
> * Rename via git format-patch -M
> 
> Thanks to Arnd Bergmann and Wolfram Sang for reviewing!
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
