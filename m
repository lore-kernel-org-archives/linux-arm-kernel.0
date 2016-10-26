From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 26 Oct 2016 17:54:53 -0400
Subject: [PATCH V6 01/10] Documentation: DT: qcom_hidma: update binding
 for MSI
In-Reply-To: <20161026214512.ofwbxnl2d46n6ef5@rob-hp-laptop>
References: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
 <1476899512-20431-2-git-send-email-okaya@codeaurora.org>
 <20161026214512.ofwbxnl2d46n6ef5@rob-hp-laptop>
Message-ID: <34c0f239-b44c-9ca6-3cc9-20b96ac2a3a0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 5:45 PM, Rob Herring wrote:
> On Wed, Oct 19, 2016 at 01:51:43PM -0400, Sinan Kaya wrote:
>> Adding a new binding for qcom,hidma-1.1 to distinguish HW supporting
>> MSI interrupts from the older revision.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Please add acks when posting new versions.
> 

Sure, sorry about that. Your acked version already got merged to Vinod's branch.
During the merge, Vinod got some merge conflicts for the remainder of the patches. 

I was trying to post the remaining patches for Vinod to pick it up. 
Apologies if it was not clear.

I posted V7 with only four remaining patches without the already merged
DT changes.

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
