From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Wed, 18 Dec 2013 13:09:25 +0200
Subject: [PATCH v4 0/9] Reuse davinci-nand driver for Keystone arch
In-Reply-To: <20131218071457.GB5551@norris-Latitude-E6410>
References: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
 <20131218071457.GB5551@norris-Latitude-E6410>
Message-ID: <52B18265.5090404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2013 09:14 AM, Brian Norris wrote:
> On Tue, Dec 17, 2013 at 02:59:06PM +0200, Ivan Khoronzhuk wrote:
>> This series contains fixes and updates of Davinci nand driver in
>> order to reuse it for Keystone platform.
>>
>> v3..v4:
>> - mtd: nand: davinci: fix driver registration
>> 	dropped __init/__exit/__exit_p as module_platform_driver() is used
>> - mtd: nand: davinci: adjust DT properties to MTD generic
>> 	used of_get_nand_bus_width() helper
>> - mtd: nand: davinci: don't request AEMIF address range
>> 	added comment at code change
>
> Pushed the series to l2-mtd.git. Thanks!
>
> Brian
>

Thanks

-- 
Regards,
Ivan Khoronzhuk
