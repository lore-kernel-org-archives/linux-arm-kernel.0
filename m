From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 5 Sep 2017 13:53:17 +0100
Subject: [RFC PATCH 4/6] iommu/arm-smmu-v3: Add SVM support for platform
 devices
In-Reply-To: <1504167642-14922-5-git-send-email-xieyisheng1@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <1504167642-14922-5-git-send-email-xieyisheng1@huawei.com>
Message-ID: <039adc54-00f5-bf4e-e509-ffdc67baa15e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/17 09:20, Yisheng Xie wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Platform device can realise SVM function by using the stall mode. That
> is to say, when device access a memory via iova which is not populated,
> it will stalled and when SMMU try to translate this iova, it also will
> stall and meanwhile send an event to CPU via MSI.
> 
> After SMMU driver handle the event and populated the iova, it will send
> a RESUME command to SMMU to exit the stall mode, therefore the platform
> device can contiue access the memory.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

No. Please don't forge a signed-off-by under a commit message you wrote,
it's rude. I didn't sign it, didn't consider it fit for mainline or even
as an RFC, and wanted to have another read before sending. My mistake,
I'll think twice before sharing prototypes in the future.

Thanks,
Jean
