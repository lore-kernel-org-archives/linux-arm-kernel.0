From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2015 18:50:13 +0000
Subject: [RFC PATCH] arm64: make Timer Interrupt Frequency selectable
In-Reply-To: <1445831296-7020-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1445831296-7020-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20151028185012.GH8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 11:48:16AM +0800, Kefeng Wang wrote:
> It allows a selectable timer interrupt frequency of 100, 250, 300 and 1000 HZ.
> We will get better performance when choose a suitable frequency in some scene.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Queued for 4.4. Thanks.

-- 
Catalin
