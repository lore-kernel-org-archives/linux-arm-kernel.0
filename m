From: jhnikula@gmail.com (Jarkko Nikula)
Date: Mon, 7 Mar 2011 16:40:33 +0200
Subject: [PATCH V3 13/19] OMAP3+: SR: Reuse sr_[start|stop]_vddautocomp
	functions
In-Reply-To: <1299338962-5602-14-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-14-git-send-email-nm@ti.com>
Message-ID: <20110307164033.01a3b67c.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat,  5 Mar 2011 20:59:16 +0530
Nishanth Menon <nm@ti.com> wrote:

> From: Jarkko Nikula <jhnikula@gmail.com>
> 
> sr_start_vddautocomp and sr_stop_autocomp functions can be reused from
> omap_sr_enable, omap_sr_disable and omap_sr_disable_reset_volt and by
> adding one additional argument sr_stop_autocomp. This allows us to have
> a single point where SR enable and disable operations are controlled from.
> 
> [nm at ti.com: synced it up with class start/stop as well. autocomp flag
>  should only be disabled when SR is disabled for that domain]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> Side note: Jarkko has'nt seen this rev as I just finished the rebase and tested
> but adding his signed-off anyways as he is primary contributor to the idea
> and the patch.
> 
This version looks good to me. We agreed with Nishant that squashing my
trivial patches with Nishant's set makes the most sense.

-- 
Jarkko
