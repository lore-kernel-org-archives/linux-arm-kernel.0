From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 16:30:05 -0700
Subject: [PATCHv6 5/6] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1370444578-25721-6-git-send-email-dinguyen@altera.com>
References: <1370444578-25721-1-git-send-email-dinguyen@altera.com>
 <1370444578-25721-6-git-send-email-dinguyen@altera.com>
Message-ID: <20130611233005.GE23774@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 05, 2013 at 10:02:57AM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> Add "syscon" to the "altr,sys-mgr" binding.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> CC: <linux@arm.linux.org.uk>

This looks reasonable to me, but you should always cc bindings updates like
these both to the devicetree-discuss mailing list and Rob Herring/Grant Likely,
and in this case since it's for MMC bindings, the linux-mmc list should also
be on cc.


-Olof
