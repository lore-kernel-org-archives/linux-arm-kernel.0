From: agross@codeaurora.org (Andy Gross)
Date: Fri, 4 Sep 2015 15:35:47 -0500
Subject: [PATCH v2 0/8] SMEM/SMD/SMD_RPM big endian support + tidying
In-Reply-To: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150904203547.GB31824@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 03:46:43PM -0700, Stephen Boyd wrote:
> This supersedes the 3 "series" of patches to move smem to big endian,
> smd to big endian, and make qcom_smem_get() return a pointer.
> 
> I've moved the qcom_smem_get() returning a pointer part to the beginning
> of the series so it can be applied earlier if desired. I imagine the
> first 7 patches can go through arm-soc, and the last patch Mark can pick
> up anytime. All patches tested on apq8074 dragonboard.
> 
> I've already written the patches to add __ioread32_copy(), but I'm
> holding them until -rc1 drops because I'd rather not involve even
> more people in this series just yet.
> 

All of these look fine to me.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
