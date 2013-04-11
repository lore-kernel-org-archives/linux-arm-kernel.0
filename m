From: cjb@laptop.org (Chris Ball)
Date: Wed, 10 Apr 2013 21:06:18 -0400
Subject: [PATCH 09/30] mmc: sdhci-s3c: remove platform dependencies
In-Reply-To: <1365638712-1028578-10-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Thu, 11 Apr 2013 02:04:51 +0200")
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-10-git-send-email-arnd@arndb.de>
Message-ID: <877gk9j2ph.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 10 2013, Arnd Bergmann wrote:
> plat/regs-sdhci.h is not used anywhere but in the sdhci-s3c
> driver, so it can become a local file there and all other
> inclusions removed.
>
> plat/sdhci.h is used only to define the platform devices,
> and with the exception of the platform_data structure not
> needed by the driver, so we can split out the platform_data
> definition instead and leave the rest to platform code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mmc at vger.kernel.org
> Cc: Chris Ball <cjb@laptop.org>

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
