From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 30 Sep 2011 15:05:47 +0530
Subject: [PATCH v3] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <1317353481-28723-1-git-send-email-Barry.Song@csr.com>
References: <1317353481-28723-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CAMQu2gzc4Zx2ria+PPt6F+bWGJzjthwnooYCKGyHtm9Q=Qp1iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 9:01 AM, Barry Song <Barry.Song@csr.com> wrote:
> From: Barry Song <Baohua.Song@csr.com>
>
> we save the l2x0 registers at the first initialization, and platform codes
> can get them to restore l2x0 status after wakeup.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
> ?-v3:
> ?save PREFETCH_CTRL and POWER_CTRL according to revision;
> ?save l2x0 physical address so that asm codes can use.
>
Thanks for the update.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
