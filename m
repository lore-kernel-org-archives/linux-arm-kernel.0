From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 9 Aug 2012 12:53:33 +0530
Subject: [PATCH v2 2/2] ARM: OMAP4: Register the OPP table only for 4430
 device
In-Reply-To: <1344496102-24451-3-git-send-email-rnayak@ti.com>
References: <1344496102-24451-1-git-send-email-rnayak@ti.com>
 <1344496102-24451-3-git-send-email-rnayak@ti.com>
Message-ID: <CAMQu2gxq2x=Qrr2-bpkDdAu-KVuMBZiZnhv-fzUnv2q02667Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 12:38 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> The 4430 OPP table was being registered for all other OMAP4 variants
> too, like 4460 and 4470 causing issues with cpufreq driver
> enabled. 4460 and 4470 devices have different OPPs as compared to
> 4430, and they should be populated seperately. As long as that
> happens, let the OPP table registeration happen only on 4430 device.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
