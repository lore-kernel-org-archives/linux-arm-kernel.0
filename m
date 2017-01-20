From: tj@kernel.org (Tejun Heo)
Date: Fri, 20 Jan 2017 08:28:43 -0500
Subject: [PATCH v5 00/14] ARM: da850-lcdk: add SATA support
In-Reply-To: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20170120132843.GA31487@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 12:21:51PM +0100, Bartosz Golaszewski wrote:
> This series contains all the changes necessary to make SATA work on
> the da850-lcdk board.
> 
> The first patch adds DT bindings for the ahci-da850 driver.
> 
> The second enables relevant modules in davinci_all_defconfig.
> 
> Patches 03/14-06/14 modify the way the clocks are handled regarding
> SATA on the da850 platform. We modify the ahci driver to retrieve
> the clock via con_id and model the external SATA oscillator as
> a real clock.
> 
> Patches 07/14-11/14 extend the ahci-da850 driver. Add DT support,
> implement workarounds necessary to make SATA work on the da850-lcdk
> board and un-hardcode the external clock multiplier.

Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

to the all libata patches.  Please let me know how the patches should
be routed once other parts are settled.

Thanks.

-- 
tejun
