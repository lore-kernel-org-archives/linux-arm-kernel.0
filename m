From: elder@linaro.org (Alex Elder)
Date: Wed, 25 Oct 2017 10:12:02 -0500
Subject: [PATCH 0/3] arm64: remove some unused defconfig options
In-Reply-To: <20171025070253.GD28555@hector>
References: <20171020172021.8119-1-elder@linaro.org>
 <20171025002019.GC30645@codeaurora.org> <20171025070253.GD28555@hector>
Message-ID: <50fc14c8-9272-4c88-6625-7cbf1af09879@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2017 02:02 AM, Andy Gross wrote:
> On Tue, Oct 24, 2017 at 05:20:20PM -0700, Stephen Boyd wrote:
>> On 10/20, Alex Elder wrote:
>>> This series deletes three config options related to USB on Qualcomm
>>> SoCs from the arm64 "defconfig", along with the code that they
>>> enable.  The code is no longer needed by any Qualcomm hardware.  
>>>
>>> 					-Alex
>>>
>>> Alex Elder (3):
>>>   arm64: defconfig: remove CONFIG_USB_EHCI_MSM
>>>   arm64: defconfig: remove CONFIG_USB_MSM_OTG
>>>   arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY
>>
>> As I said off-list, I would split this into defconfig for arm-soc
>> and drivers/usb for usb subsystem to pick up.
> 
> I agree with splitting.  But carry my ACKs when you do.

I will.  And I'll send two series, one for defconfig and
one for the drivers.  Thanks.

					-Alex
