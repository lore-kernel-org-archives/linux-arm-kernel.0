From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Apr 2018 14:21:00 +0530
Subject: [PATCH v2 0/2] memory: aemif: add support for machine code
In-Reply-To: <0f2903da-b670-dc85-e61b-64cac90a6c34@oracle.com>
References: <20180419151252.26212-1-brgl@bgdev.pl>
 <0f2903da-b670-dc85-e61b-64cac90a6c34@oracle.com>
Message-ID: <4d72accf-7d63-c725-0b67-253ed6818ae0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 April 2018 10:54 PM, santosh.shilimkar at oracle.com wrote:
> On 4/19/18 8:12 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This is a follow-up to the series that contained both changes to the
>> aemif driver and platform code. It contains only the driver changes.
>>
>> As the first step in removing duplicate support for aemif from the
>> kernel we need to add support for board files to the aemif memory
>> driver.
>>
>> First patch just uses a static string for the ti-aemif driver name.
>>
>> The second adds support for board files to the aemif driver.
>>
>> This series includes changes requested by Sekhar in his code review:
>> - made aemif the parent of each sub-device before registering it
>> - documented the new members in aemif_platform_data
>>
>> v1 -> v2:
>> - actually iterate over abus entries instead of always accessing the
>> ?? first one
>>
>> Bartosz Golaszewski (2):
>> ?? memory: aemif: don't rely on kbuild for driver's name
>> ?? memory: aemif: add support for board files
>>
> Applied. Should show up in next soon.
> 
> Sekhar, You can use below branch.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git ?'for_4.18/soc-drivers'

Thanks Santosh!

Regards,
Sekhar
