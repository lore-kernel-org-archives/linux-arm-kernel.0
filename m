From: greg@kroah.com (Greg KH)
Date: Mon, 11 Apr 2011 16:35:51 -0700
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
Message-ID: <20110411233551.GB13240@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 01:57:07AM +0200, Rafa? Mi?ecki wrote:
> Cc: Michael B?sch <mb@bu3sch.de>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: George Kashperko <george@znau.edu.ua>
> Cc: Arend van Spriel <arend@broadcom.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Botting <andy@andybotting.com>
> Cc: linuxdriverproject <devel@linuxdriverproject.org>
> Cc: linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> V2: Rename to axi
>     Use DEFINE_PCI_DEVICE_TABLE in bridge
>     Make use of pr_fmt and pr_*
>     Store core class
>     Rename bridge to not b43 specific
>     Replace magic 0x1000 with BCMAI_CORE_SIZE
>     Remove some old "ssb" names and defines
>     Move BCMAI_ADDR_BASE def
>     Add drvdata field
> V3: Fix reloading (kfree issue)
>     Add 14e4:0x4331
>     Fix non-initialized struct issue
>     Drop useless inline functions wrappers for pci core drv
>     Proper pr_* usage
> V3.1: Include forgotten changes (pr_* and include related)
>     Explain why we dare to implement empty release function

Nope, still not allowed, see my other email, sorry.

thanks,

greg k-h
