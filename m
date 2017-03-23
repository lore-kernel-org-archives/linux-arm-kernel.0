From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Mar 2017 14:21:58 +0000
Subject: [PATCH] arm64: drop unnecessary newlines in show_regs()
In-Reply-To: <1490013775-22475-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1490013775-22475-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20170323142157.GE14290@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 08:42:55PM +0800, Kefeng Wang wrote:
> There are two unnecessary newlines, one is in show_regs, another
> is in __show_regs(), drop them.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Queued for 4.12. Thanks.

-- 
Catalin
