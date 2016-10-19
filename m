From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Oct 2016 08:36:24 -0700
Subject: [PATCH V5 00/10] dmaengine: qcom_hidma: add MSI interrupt support
In-Reply-To: <20161019133406.GO2467@localhost>
References: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
 <20161019133406.GO2467@localhost>
Message-ID: <ec05315c-a527-f107-6cf3-ac71803d0a57@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2016 6:34 AM, Vinod Koul wrote:
> On Fri, Oct 07, 2016 at 01:25:05AM -0400, Sinan Kaya wrote:
>> The new version of the HW supports MSI interrupts instead of wired
>> interrupts. The MSI interrupts are especially useful for the guest machine
>> execution. The wired interrupts usually trap to the hypervisor and then are
>> relayed to the actual interrupt.
>>
>> The MSI interrupts can be directly fed into the interrupt controller.
>>
>> Adding a new OF compat string (qcom,hidma-1.1) and ACPI string (QCOM8062)
>> to distinguish newer HW from the older ones.
> 
> I was only able to apply 6 patches in this series. Which tree were these
> generated against?
> 
> Please rebase rest..
> 

Sure, let me do that. The other two patches (sysfs and debugfs) probably broke
the git merge.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
