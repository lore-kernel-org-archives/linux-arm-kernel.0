From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 11:01:24 +0100
Subject: [PATCH] ARM: socfpga_defconfig: enable support for
 initramfs/initrd support
In-Reply-To: <7hwpqaoj69.fsf@baylibre.com>
References: <1455230856-19648-1-git-send-email-dinguyen@opensource.altera.com>
 <4776059.MG11XzgNhU@wuerfel> <7hwpqaoj69.fsf@baylibre.com>
Message-ID: <3329414.HcXjecCDpd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 February 2016 16:40:14 Kevin Hilman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Thursday 11 February 2016 16:47:36 dinguyen at opensource.altera.com wrote:
> >> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> >> 
> >> Enable CONFIG_BLK_DEV_INITRD.
> >> 
> >> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> >
> > What for?
> >
> 
> So the board farms doing boot testing can do so with an initramfs.
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>

Ah, got it. I thought this was just the option for the old-style blockdev
based initrd, not the new-style initramfs.

	Arnd
