From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 11 Feb 2016 16:40:14 -0800
Subject: [PATCH] ARM: socfpga_defconfig: enable support for
 initramfs/initrd support
In-Reply-To: <4776059.MG11XzgNhU@wuerfel> (Arnd Bergmann's message of "Fri, 12
 Feb 2016 00:01:18 +0100")
References: <1455230856-19648-1-git-send-email-dinguyen@opensource.altera.com>
 <4776059.MG11XzgNhU@wuerfel>
Message-ID: <7hwpqaoj69.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 11 February 2016 16:47:36 dinguyen at opensource.altera.com wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>> 
>> Enable CONFIG_BLK_DEV_INITRD.
>> 
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> What for?
>

So the board farms doing boot testing can do so with an initramfs.

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin
