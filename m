From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 10 Sep 2014 14:08:36 +0530
Subject: [PATCH 0/3]  Add picoPHY usb phy driver found on stih407 family
 SoC's
In-Reply-To: <20140908155331.GA7620@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1409740079-16554-1-git-send-email-peter.griffin@linaro.org>
 <540DC9F6.8090306@ti.com>
 <20140908155331.GA7620@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <54100E0C.7070309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 08 September 2014 09:23 PM, Peter Griffin wrote:
> Hi Kishon,
> 
>> On Wednesday 03 September 2014 03:57 PM, Peter Griffin wrote:
>>> This series adds support for the picoPHY usb phy which is used by the usb2
>>> and usb3 host controllers when controlling usb2/1.1 devices. It is found on
>>> stih407 family SoC's from the consumer electronics devision of STMicroelectronics.
>>
>> So miphy28lp is the PHY controller for USB3 device controller and picoPHY is
>> the PHY controller for USB3 host controller?
> 
> No, miphy28lp is the usb3 phy and picoPHY is the usb2 phy.
> 
> With a usb2 host controller only picoPHY is used. With the usb3 host controller both usb2 and usb3 phys
> are used depending on what type of device is plugged in.
> 
> Hope that clarifies things,

indeed. thanks for the explanation :-)

Cheers
Kishon
