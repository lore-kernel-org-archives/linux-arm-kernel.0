From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 15 May 2013 11:44:08 -0500
Subject: [PATCH 1/5] ARM: socfpga: dts: Add ethernet bindings for SOCFPGA
In-Reply-To: <20130515124302.GB9066@amd.pavel.ucw.cz>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com>
 <20130515124302.GB9066@amd.pavel.ucw.cz>
Message-ID: <5193BB58.2040109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Thanks for the review...

On 05/15/2013 07:43 AM, Pavel Machek wrote:
> On Tue 2013-05-14 17:52:31, dinguyen at altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Add entry for 2nd GMAC controller. Add the correct clocks for the GMAC.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Olof Johansson <olof@lixom.net>
>> CC: Pavel Machek <pavel@denx.de>
>> CC: <linux@arm.linux.org.uk>
> 
> Looks good.
> 
> Reviewed-by: Pavel Machek <pavel@denx.de>
> 
> ...but, this patch is not enough to get ethernet to work with
> 3.10-rc1, right? I hoped that applying 1-3 of the series would get me
> ethernet, but no :-(.

Yes, this fixes a build error for socfpga_defconfig in 3.10-rc1. I'll
send a patch to enable ethernet after these patches are accepted.

Dinh


> 
> Thanks,
> 									Pavel
> 
