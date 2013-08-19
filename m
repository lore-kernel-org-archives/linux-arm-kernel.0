From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 19 Aug 2013 15:56:18 +0530
Subject: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,
 palmas-usb-vid*
In-Reply-To: <5211F191.7010303@baylibre.com>
References: <1376648448-27447-1-git-send-email-kishon@ti.com>
 <520EA5D6.3040409@wwwdotorg.org> <5211A7B3.4040906@ti.com>
 <5211DBB4.6090508@ti.com> <5211E45B.1010109@samsung.com>
 <5211E563.6080200@ti.com> <5211F191.7010303@baylibre.com>
Message-ID: <5211F2CA.8090206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 August 2013 03:51 PM, Benoit Cousson wrote:
> Hi Kishon,
> 
> On 19/08/2013 11:29, Kishon Vijay Abraham I wrote:
>> On Monday 19 August 2013 02:54 PM, Chanwoo Choi wrote:
>>> On 08/19/2013 05:47 PM, Kishon Vijay Abraham I wrote:
>>>> On Monday 19 August 2013 10:35 AM, Kishon Vijay Abraham I wrote:
>>>>> Hi,
>>>>>
>>>>> On Saturday 17 August 2013 03:51 AM, Stephen Warren wrote:
>>>>>> On 08/16/2013 04:20 AM, Kishon Vijay Abraham I wrote:
>>>>>>> The Palmas device contains only a USB VID detector, so modified the
>>>>>>> compatible type to *ti,palmas-usb-vid*.
>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>>>>>>> b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
> 
> That file is not yet in 3.11. Only the twl is there.
> Is this one a rename of the twl one?

yes Benoit. This is the commit
http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=80d644b297dc26c5126858555044edef76f4ffe8

Thanks
Kishon
