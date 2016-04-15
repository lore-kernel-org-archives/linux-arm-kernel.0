From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Apr 2016 18:20:48 +0100
Subject: [PATCH] arm64: mm: Enhance Virtual kernel memory layout
In-Reply-To: <1460533772-13314-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460533772-13314-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160415172047.GA8490@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On Wed, Apr 13, 2016 at 03:49:32PM +0800, Kefeng Wang wrote:
> 1) Show kernel excetion vector region and bss segment information.
> 2) Only show modules and PCI I/O with corresponding config enabled.
> 3) Each line with single pr_cont, or lead to anomalous print in dmesg.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Can you post a new version of this patch addressing James's feedback,
please?

Thanks,

Will
