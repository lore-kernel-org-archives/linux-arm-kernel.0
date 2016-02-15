From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Feb 2016 10:09:06 +0000
Subject: [PATCH] arm64: mm: dump: Use VA_START directly instead of
 private LOWEST_ADDR
In-Reply-To: <56C0416E.6050908@huawei.com>
References: <1454140521-741-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160201102345.GB674@leverpostej> <56C0416E.6050908@huawei.com>
Message-ID: <20160215100906.GB13683@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 14, 2016 at 04:57:18PM +0800, Kefeng Wang wrote:
> On 2016/2/1 18:23, Mark Rutland wrote:
> > On Sat, Jan 30, 2016 at 03:55:21PM +0800, Kefeng Wang wrote:
> >> Use VA_START macro in asm/memory.h instead of private LOWEST_ADDR
> >> definition in dump.c.
> >>
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I'll merge this patch for 4.6 but we currently have some issues with the
arm64 for-next/core branch, so I'm not pushing any more patches out
until we figure out what's going on (or I may just start with a clean
branch again, removing some big changes in there).

-- 
Catalin
