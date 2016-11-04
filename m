From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sat, 5 Nov 2016 02:34:10 +0530
Subject: [PATCH 2/3] phy: da8xx-usb: rename the ohci device to ohci-da8xx
In-Reply-To: <2c3b66c5-b148-252e-36a0-e067bb60191e@ti.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
 <20161102124435.31777-3-ahaslam@baylibre.com>
 <fd6b848d-9740-70ef-6850-7f6a64e66bfb@ti.com>
 <2c3b66c5-b148-252e-36a0-e067bb60191e@ti.com>
Message-ID: <114136e8-c803-f819-70a2-ad8b4a3f2b9b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 04 November 2016 11:04 AM, Sekhar Nori wrote:
> Hi Kishon,
> 
> On Thursday 03 November 2016 10:20 PM, Kishon Vijay Abraham I wrote:
>>
>>
>> On Wednesday 02 November 2016 06:14 PM, Axel Haslam wrote:
>>> There is only one ohci on the da8xx series of chips,
>>> so remove the ".0" when creating the phy. Also add
>>> the "-da8xx" postfix to be consistent across davinci
>>> usb drivers.
>>>
>>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> You will have to carry this patch from your tree. I thought I can carry
> the entire series, but the USB patch depends on other patches that Greg
> has already queued. So I think its best if the individual patches go
> through their respective trees.
> 
> Note that there is a v2 already submitted.

Okay. I can pick them in my tree.

Thanks
Kishon
