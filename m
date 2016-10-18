From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 18 Oct 2016 14:36:02 +0530
Subject: [STLinux Kernel] [PATCH 02/19] phy: stih41x-usb: Remove usb phy
 driver and dt binding documentation.
In-Reply-To: <59fa8f92-114b-7b5f-fd2f-46c4f02b545e@st.com>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-3-git-send-email-peter.griffin@linaro.org>
 <20160923150656.GB9176@rob-hp-laptop>
 <778bd4b2-9e82-326b-f6e0-43360323d453@st.com>
 <59fa8f92-114b-7b5f-fd2f-46c4f02b545e@st.com>
Message-ID: <5805E5FA.6020609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 18 October 2016 02:22 PM, Patrice Chotard wrote:
> 
> 
> On 10/18/2016 09:47 AM, Patrice Chotard wrote:
>> Hi 
>>
>> On 09/23/2016 05:06 PM, Rob Herring wrote:
>>> On Wed, Sep 14, 2016 at 02:27:40PM +0100, Peter Griffin wrote:
>>>> This phy is only used on STiH415/6 based silicon, and support for
>>>> these SoC's is being removed from the kernel.
>>>>
>>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>>> Cc: <kishon@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/phy/phy-stih41x-usb.txt    |  24 ---
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> Applied on sti-dt-for-4.10 branch
> 
> 
> Sorry, i did a mistake, these patch should go in linux-phy tree.
> Kishon will you take care of it ?

sure, will queue this.

Thanks
Kishon

> 
> Thanks
> 
>>
>> Thanks 
>>
>>
>>>
>>>>  drivers/phy/Kconfig                                |   8 -
>>>>  drivers/phy/Makefile                               |   1 -
>>>>  drivers/phy/phy-stih41x-usb.c                      | 188 ---------------------
>>>>  4 files changed, 221 deletions(-)
>>>>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
>>>>  delete mode 100644 drivers/phy/phy-stih41x-usb.c
>>
>> _______________________________________________
>> Kernel mailing list
>> Kernel at stlinux.com
>> http://www.stlinux.com/mailman/listinfo/kernel
>>
