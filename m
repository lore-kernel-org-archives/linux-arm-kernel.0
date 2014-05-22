From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 22 May 2014 20:16:16 +0300
Subject: [Patch v6 3/7] mfd: ti-keystone-devctrl: add bindings for device
 state control
In-Reply-To: <20140522171148.GL19747@lee--X1>
References: <1400777062-19276-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400777062-19276-4-git-send-email-ivan.khoronzhuk@ti.com>
 <20140522171148.GL19747@lee--X1>
Message-ID: <537E30E0.8050403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/22/2014 08:11 PM, Lee Jones wrote:
> On Thu, 22 May 2014, Ivan Khoronzhuk wrote:
>
>> The Keystone II devices have a set of registers that are used to control
>> the status of its peripherals. This node is intended to allow access to
>> this functionality.
>>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> ---
>>   .../devicetree/bindings/mfd/ti-keystone-devctrl.txt   | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
> Applied, thanks.
>

Thanks.

-- 
Regards,
Ivan Khoronzhuk
