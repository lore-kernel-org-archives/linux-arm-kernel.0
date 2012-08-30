From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 30 Aug 2012 09:49:54 -0700
Subject: [PATCH - 2/2] arm: disable caches based on config option
In-Reply-To: <1346337826-27232-2-git-send-email-m-karicheri2@ti.com>
References: <1346337826-27232-1-git-send-email-m-karicheri2@ti.com>
 <1346337826-27232-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <CAMQu2gyuVHEz-gUK3Tzqy4DPRwP+NWWjJTCYS=-RzFuszHw9Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 7:43 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> CONFIG_CPU_ICACHE_DISABLE and CONFIG_CPU_DCACHE_DISABLE are available
> to allow disabling of D-Cache and I-Cache. However the compressed version
> of head.S currently doesn't check these variables. This patch will fix
> this issue and is written similar to the uncompressed version of head.S
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
