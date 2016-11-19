From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 18:32:46 -0800
Subject: [GIT PULL 3/10] reset: Add Tegra BPMP reset driver
In-Reply-To: <20161118161719.24153-3-thierry.reding@gmail.com>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
 <20161118161719.24153-3-thierry.reding@gmail.com>
Message-ID: <20161119023246.GM2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 05:17:12PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-reset
> 
> for you to fetch changes up to dc606c5205536a828c17bd96f06559dafaf75fb7:
> 
>   reset: Add Tegra BPMP reset driver (2016-11-18 14:34:56 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> reset: Add Tegra BPMP reset driver
> 
> This contains a patch which implements a reset driver using the services
> provided by the BPMP firmware (via the MRQ_RESET request).
> 
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells()
> 
> Joseph Lo (3):
>       soc/tegra: Add Tegra186 support
>       dt-bindings: mailbox: Add Tegra HSP binding
>       dt-bindings: firmware: Add bindings for Tegra BPMP
> 
> Stephen Warren (2):
>       dt-bindings: Add power domains to Tegra BPMP firmware
>       dt-bindings: firmware: Allow child nodes inside the Tegra BPMP
> 
> Thierry Reding (7):
>       Merge branch 'for-4.10/soc' into for-4.10/mailbox
>       mailbox: Add Tegra HSP driver
>       Merge branch 'for-4.10/mailbox' into for-4.10/firmware
>       firmware: tegra: Add IVC library
>       firmware: tegra: Add BPMP support
>       Merge branch 'for-4.10/firmware' into for-4.10/reset
>       reset: Add Tegra BPMP reset driver

Same comments apply here, since this branch only adds one more driver.

Merged into next/drivers with the other branches so far.


-Olof
