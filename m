From: wufan@codeaurora.org (wufan)
Date: Mon, 3 Sep 2018 09:05:29 -0600
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <5B891308.40407@huawei.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <5eab89c6-c063-cbc2-4d02-459faf87698a@arm.com>
 <6cc3c5e2-3827-a89c-e37b-09728a34f21f@huawei.com> <5B891308.40407@huawei.com>
Message-ID: <003201d44397$8eb02c20$ac108460$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks tanxiaofei!

Boris/James, are you OK to sign off, or you want to see more tests on 
this patch? 

Thanks,
Fan

> -----Original Message-----
> From: tanxiaofei <tanxiaofei@huawei.com>
> Sent: Friday, August 31, 2018 4:06 AM
> 
> Hi James,
> 
> Our platform do not set CPER_MEM_VALID_MODULE_HANDLE in GHES
> Memory errors.
> 
> Thanks,
> tanxiaofei
