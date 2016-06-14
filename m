From: marex@denx.de (Marek Vasut)
Date: Tue, 14 Jun 2016 23:08:58 +0200
Subject: [PATCH] ARM: socfpga: Update socfpga_defconfig
In-Reply-To: <alpine.DEB.2.02.1606141536130.4855@linux-builds1>
References: <1462480394-8084-1-git-send-email-marex@denx.de>
 <alpine.DEB.2.02.1606141536130.4855@linux-builds1>
Message-ID: <5760726A.5050507@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2016 10:37 PM, Dinh Nguyen wrote:
> On Thu, 5 May 2016, Marek Vasut wrote:
> 
>> Enable the following bits:
>>
>> CONFIG_TOUCHSCREEN_STMPE
>>  - STMPE touchscreen support, needed on MCVEVK as it contains the
>>    chip. This also enables the STMPE MFD device and touchscreen
>>    input support.
>>
>> CONFIG_USB_STORAGE
>>  - USB storage support is often used, so enable it.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>>  arch/arm/configs/socfpga_defconfig | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
> 
> Sorry that this took me a while, I missed it somehow. Anywways, applied! 

No problem, thanks!

> Thanks,
> Dinh
> 


-- 
Best regards,
Marek Vasut
