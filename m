From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 20 Feb 2017 14:00:49 +0530
Subject: [PATCH 1/3] ARM: davinci: PM: Drop useless check for
 PM_SUSPEND_STANDBY
In-Reply-To: <1487347836-14427-2-git-send-email-geert+renesas@glider.be>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <1487347836-14427-2-git-send-email-geert+renesas@glider.be>
Message-ID: <76eb3b09-80bd-eb5a-db32-744a7b9e1f2c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 February 2017 09:40 PM, Geert Uytterhoeven wrote:
> As DaVinci uses the standard suspend_valid_only_mem() for its
> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
> callback will never be called with state equal to PM_SUSPEND_STANDBY.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good to me. Whats the plan for applying the series. Do you want
the individual machine maintainers to apply their parts. Or some other?

Thanks,
Sekhar
