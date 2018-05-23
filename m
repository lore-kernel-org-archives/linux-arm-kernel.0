From: toshi.kani@hpe.com (Kani, Toshi)
Date: Wed, 23 May 2018 14:34:06 +0000
Subject: [PATCH v9 3/4] arm64: Implement page table free interfaces
In-Reply-To: <20180523140157.GG26965@arm.com>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
 <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
 <20180523140157.GG26965@arm.com>
Message-ID: <1527085967.14039.10.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-05-23 at 15:01 +0100, Will Deacon wrote:
> Hi Chintan,
> 
> [as a side note: I'm confused on the status of this patch series, as part
>  of it was reposted separately by Toshi. Please can you work together?]

I do not know the status of my patch series, either... That being said,
I made my x86 patches based off from Chintan's 1/4 patch (which changes
both x86 and arm) so that my series won't conflict with his.

Chintan,
If you need to update your series before mine's accepted, please make
sure to use the updated 1/4 below. I've updated the descriptions per
review comment.
https://patchwork.kernel.org/patch/10407065/

Thanks,
-Toshi 
