From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 5 Feb 2018 18:43:58 +0000
Subject: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
In-Reply-To: <20180205181513.GB878@jcrouse-lnx.qualcomm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
 <0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
 <c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
 <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
 <20171012152803.GA3027@jcrouse-lnx.qualcomm.com>
 <8539601d-ef7a-8dd0-2fc7-51240c292678@arm.com>
 <20171025202015.GA6159@jcrouse-lnx.qualcomm.com>
 <20180205181513.GB878@jcrouse-lnx.qualcomm.com>
Message-ID: <3896a835-7178-2aa3-44dd-80dd98f41b46@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jordan,

On 05/02/18 18:15, Jordan Crouse wrote:
[...]
> Just a gentle nudge to see if there is any progress on this front. I know the
> last 6 months have been busy with other far more serious panics but I wanted to
> offer any help I could provide including testing on various qcom targets.

If everything goes well I should be able to send v1 of this series next
week, and I believe the patches implementing sva_map()/sva_unmap() will
soon follow.

Thanks,
Jean
