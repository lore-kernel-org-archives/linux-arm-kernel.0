From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 2 Mar 2018 13:37:11 -0500
Subject: RFC on Kdump and PCIe on ARM64
In-Reply-To: <20180302180219.GB20579@arm.com>
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
 <20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
 <2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
 <20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
 <20180302103032.GB19323@arm.com>
 <84121a8d-5294-0567-6c6b-f57e85dc4961@codeaurora.org>
 <20180302180219.GB20579@arm.com>
Message-ID: <2f8e1f65-5f70-9556-5d96-c50421982f73@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/2/2018 1:02 PM, Will Deacon wrote:
>> How about the points that Baoquan highlighted in his email regarding the
>> solution from AMD and X86?
> Which specific points do you think this proposal doesn't address?
> 

No specific concerns at this moment.

>> I have not read the entire thread but, is this just a matter of following
>> what Bjorn recommended or there is more to it?
> I'm trying to say how I think Bjorn's idea can be implemented for SMMUv3.
> I basically want to avoid a situation where the SMMU driver tries to walk
> the in-memory data structures left by a previous kernel and infer the
> setup from that.

Let me know if you have something to test. We have a test case with the
crash.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
