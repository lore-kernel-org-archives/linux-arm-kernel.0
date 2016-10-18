From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 18 Oct 2016 14:48:04 +0530
Subject: [STLinux Kernel] [PATCH 01/19] phy: phy-miphy365x: Remove
 miphy365 driver and dt binding documentation.
In-Reply-To: <75b370f3-a1cd-ac6e-ce8a-b77e4c0c3847@st.com>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-2-git-send-email-peter.griffin@linaro.org>
 <20160923150636.GA9176@rob-hp-laptop>
 <12506413-515f-1a33-a642-ede60287ca3b@st.com>
 <75b370f3-a1cd-ac6e-ce8a-b77e4c0c3847@st.com>
Message-ID: <5805E8CC.9070702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 18 October 2016 02:15 PM, Patrice Chotard wrote:
> 
> 
> On 10/18/2016 09:47 AM, Patrice Chotard wrote:
>> Hi
>>
>> On 09/23/2016 05:06 PM, Rob Herring wrote:
>>> On Wed, Sep 14, 2016 at 02:27:39PM +0100, Peter Griffin wrote:
>>>> This phy is only used on STiH415/6 based silicon, and support for
>>>> these SoC's is being removed from the kernel.
>>>>
>>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>>> Cc: <kishon@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/phy/phy-miphy365x.txt      |  77 ---
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> Applied on sti-dt-for-4.10 branch
> 
> 
> Sorry, i did a mistake, these patch should go in linux-phy tree.
> Kishon will you take care of it ?

yes, I will.

Thanks
Kishon

> 
> Thanks
> 
>>
>> Thanks 
>>
>>>
>>>>  drivers/phy/Kconfig                                |  10 -
>>>>  drivers/phy/Makefile                               |   1 -
>>>>  drivers/phy/phy-miphy365x.c                        | 625 ---------------------
>>>>  4 files changed, 713 deletions(-)
>>>>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-miphy365x.txt
>>>>  delete mode 100644 drivers/phy/phy-miphy365x.c
>>
>>
>> _______________________________________________
>> Kernel mailing list
>> Kernel at stlinux.com
>> http://www.stlinux.com/mailman/listinfo/kernel
>>
