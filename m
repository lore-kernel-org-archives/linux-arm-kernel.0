From: davidb@codeaurora.org (David Brown)
Date: Mon, 13 Jun 2011 11:26:14 -0700
Subject: [PATCH v2 2/4] msm: iommu: move to drivers/iommu/
In-Reply-To: <1307742947-32118-3-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Sat, 11 Jun 2011 00:55:45 +0300")
References: <1307742947-32118-1-git-send-email-ohad@wizery.com>
	<1307742947-32118-3-git-send-email-ohad@wizery.com>
Message-ID: <8yaips9fv09.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10 2011, Ohad Ben-Cohen wrote:

> This should ease finding similarities with different platforms,
> with the intention of solving problems once in a generic framework
> which everyone can use.
>
> Compile-tested for MSM8X60.

Acked-by: David Brown <davidb@codeaurora.org>

I believe that Stepan Moskovochenko has some extra tests for this code,
but given that none of the code itself changes, I wouldn't expect any
problems.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
