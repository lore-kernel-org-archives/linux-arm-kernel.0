From: kholmanskikh.s.s@gmail.com (Stanislav Kholmanskikh)
Date: Sun, 18 Oct 2015 12:29:03 +0300
Subject: [PATCH] staging: wilc1000: restore wilc_spi_dev variable
In-Reply-To: <4978401.AVrDN2jmbq@wuerfel>
References: <4978401.AVrDN2jmbq@wuerfel>
Message-ID: <5623665F.40700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 16.10.2015 23:05, Arnd Bergmann wrote:
> A recent change to wilc1000 accidentally deleted an important
> variable, so we now get a build error when the SPI mode is
> selected:
> 
> ERROR: "wilc_spi_dev" [drivers/staging/wilc1000/wilc1000.ko] undefined!
> 
> This partially reverts the broken commit to put the variable back.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 56293ff232b9 ("staging: wilc1000: linux_wlan_spi: include header")
> ---

I'm really sorry about it, will be more careful in the future. 

Thank you for fixing this.
