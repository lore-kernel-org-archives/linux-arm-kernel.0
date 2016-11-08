From: john.garry@huawei.com (John Garry)
Date: Tue, 8 Nov 2016 15:17:45 +0000
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <1609380.NN50qvVsP7@wuerfel>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <2030692.HPgjBCTYG6@wuerfel>
 <2bac1a34-591b-6557-15bf-40db25c3d129@huawei.com>
 <1609380.NN50qvVsP7@wuerfel>
Message-ID: <4faf6fbc-cbce-f727-4f8a-502b6eb3f406@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2016 15:10, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 1:49:43 PM CET John Garry wrote:
>>
>> Hi Arnd,
>>
>> Thanks for the reference.
>>
>> I think the i2c interface doesn't fully satisfy our requirements as we
>> need more than just a slave bus address when accessing the slave device
>> (which I think is what i2c uses). We also need to pass "offset" and
>> "mod_mask" arguments to the djtag adapter to access specific registers
>> in the slave device.
>
> Ok. Are those values constant per device, or maybe a range? We may want to
> include those in the reg property as well then.
>
> 	Arnd
>

Hi Arnd,

I'm not sure, I'll defer to Tan/Anurup.

Cheers,
John

>
> .
>
