From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jun 2017 17:45:53 +0100
Subject: [PATCH v8 6/9] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <e120463d-2936-90ec-8aad-f0f7be558054@huawei.com>
References: <1495457312-237127-1-git-send-email-zhangshaokun@hisilicon.com>
 <20170608163519.GA19643@leverpostej>
 <8666a0fa-126d-e4a3-ac4b-7962f5d79942@huawei.com>
 <20170609154425.GH10665@leverpostej>
 <e120463d-2936-90ec-8aad-f0f7be558054@huawei.com>
Message-ID: <20170609164553.GB3043@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 05:09:25PM +0100, John Garry wrote:
> At this point, we would rather concentrate on our new chipset, which
> is based on same perf HW architecture (so much code reuse), but uses
> directly mapped registers and *no djtag* - in this, most of the
> upstream effort from all parties is not wasted.

FWIW, I suspect the MMIO-based PMU is going to have a smoother path
upstream, assuming it's not shared with other agents (and we don't have
another locking scheme to contend with).

Thanks,
Mark.
