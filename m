From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 May 2016 14:36:43 +0100
Subject: [PATCH v3 0/2] arm64: mm: Enhance Virtual kernel memory layout
In-Reply-To: <1463055387-19289-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463055387-19289-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160512133642.GC25355@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 08:16:25PM +0800, Kefeng Wang wrote:
> This is a micro enhance for Virtual kernel memory layout. Show bss info,
> and make each line with single pr_cont().

I already queued[1] the previous version of this after James acked it,
so if you want to make further changes, please send incremental patches
for review.

Will

[1]
https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=9974723e31d1fa99e3c0efb2ae6cbbf089c0080c
https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=d32351c8242b7067b3f3e3a6caf7a387ff43f978
