From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Sep 2014 13:04:18 -0400
Subject: [PATCH] firmware: add Keystone QMSS PDSP accumulator firmware blob
In-Reply-To: <20140925151551.GA18530@kroah.com>
References: <1411654423-29480-1-git-send-email-santosh.shilimkar@ti.com>
 <20140925151551.GA18530@kroah.com>
Message-ID: <54244B12.4010700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 11:15 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 25, 2014 at 10:13:43AM -0400, Santosh Shilimkar wrote:
>> From: Sandeep Nair <sandeep_n@ti.com>
>>
>> QMSS(Queue Manager Sub System) uses PDSPs to implement various
>> QM related functions like packet accumulation, QoS or event
>> management.
>>
>> Patch adds firmware blob for the QMSS accumulator
>> functionality.
>>
>> Cc: Michal Marek <mmarek@suse.cz>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sandeep Nair <sandeep_n@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> I know we are not adding firmware to kernel and the idea is to get them
>> loaded via rootfs. But this firmware is for an infrastructure component
>> which is needed for Keystone.
> 
> What does "infrastructure component" mean?
>
Common SOC components which are used by various subsystems like Networking,
SRIO, Crypto engines etc.

 
> What is "Keystone"?
>
Keystone is ARM based SOC architectures with bunch of SOC peripherals.
 
>> The respective drivers got into the queue
>> and the firmware was dropped from the series to follow the firmware tree.
> 
> Did you submit this to the linux-firmware tree?
> 
./scripts/get_maintainer.pl didn't give me other list. Which list am
suppose to submit it to get it to linux-firmware.

> Did the driver that needs this get merged into Linus's tree yet?
>
Its queued now for 3.18.

regards,
Santosh

 
