From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Nov 2016 09:24:28 -0500
Subject: [Linaro-acpi] ACPI namespace details for ARM64
In-Reply-To: <a0829be4-6324-758b-2fe6-a274f715a3a9@linaro.org>
References: <20161109220506.GN14322@bhelgaas-glaptop.roam.corp.google.com>
 <a0829be4-6324-758b-2fe6-a274f715a3a9@linaro.org>
Message-ID: <98c9564d-17f9-f549-6dd4-5c6abc1ba1a3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2016 6:18 PM, Al Stone wrote:
> On 11/09/2016 03:05 PM, Bjorn Helgaas wrote:
>> Hi all,
>>
>> We've been working through the details of getting ACPI to work on
>> arm64, and there have been lots of questions about what this means for
>> PCI.  I've outlined this for several people individually, but I'm
>> going to send this separately, apart from a specific patch series, to
>> make sure we're all on the same page.  Please correct my errors and
>> misunderstandings.
>>
>> Bjorn
>>
>> [snip....]
> 
> A big +1 to all of this.  This also looks like something that should
> be added to either PCI, ACPI or arm64 documentation (or even all three).
> What do you think?


I agree. In order to have compliant systems, we have to make PNP0C02 required
in the PCIe appendix of the SBSA specification.

> 
> Thank you for putting this together, Bjorn.
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
