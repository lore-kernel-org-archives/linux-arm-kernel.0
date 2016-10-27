From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 27 Oct 2016 16:48:44 +0530
Subject: [PATCH 5/5] ARM: dts: Add LEGO MINDSTORTMS EV3 dts
In-Reply-To: <38a3a10c-a269-6a9f-305c-7d38ec9b839b@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-6-git-send-email-david@lechnology.com>
 <b0022fad-a96e-86d4-71ba-2b803e5421fe@ti.com>
 <38a3a10c-a269-6a9f-305c-7d38ec9b839b@lechnology.com>
Message-ID: <d17f4ea6-7925-e926-2310-edf5887edee7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 October 2016 07:00 AM, David Lechner wrote:
> On 10/24/2016 06:58 AM, Sekhar Nori wrote:
>> On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
>>> This adds a device tree definition file for LEGO MINDSTORMS EV3.
>>
>> Thanks for the patch!
>>
>>>
>>> What is working:
>>>
>>> * Pin muxing
>>> * MicroSD card reader
>>> * UART on input port 1
>>>
>>> What is partially working:
>>>
>>> * Buttons - working after GPIO fix
>>> * LEDs - working after GPIO fix
>>> * Poweroff/reset - working after GPIO fix
>>
>> Is the GPIO fix something that will go in v4.9-rc cycle ?
>>
> 
> FYI, the fix is in linux-gpio/fixes now.

Thanks, I added the patch to my 'acked' branch which has stuff useful
for testing on davinci but not going through my tree. It gets merged
into my master branch so that branch can be used for all mach-davinci
development.

Thanks,
Sekhar
