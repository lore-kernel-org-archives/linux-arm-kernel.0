From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Jul 2014 17:09:12 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Cpufreq Updates for v3.17
In-Reply-To: <cover.1403487159.git.horms+renesas@verge.net.au>
References: <cover.1403487159.git.horms+renesas@verge.net.au>
Message-ID: <20140707000912.GG5539@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 11:25:25AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider this Renesas ARM based SoC cpufreq update for v3.17.
> 
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-cpufreq-for-v3.17
> 
> for you to fetch changes up to 06e32c91dbce3c24ccbe84e3af2a35199662bca0:
> 
>   ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile (2014-06-16 19:50:54 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Cpufreq Updates for v3.17
> 
> * Add cpufreq-cpu0 driver
> 

Technically inaccurate (for next time): This doesn't add a driver,
it adds registration of a device.

Merged into next/soc.


-Olof
