From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 17:02:06 +0100
Subject: [GIT PULL 1/2] SOCFPGA update for v3.19
In-Reply-To: <1416283415-6563-1-git-send-email-dinguyen@opensource.altera.com>
References: <1416283415-6563-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <201411201702.07092.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 November 2014, dinguyen at opensource.altera.com wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling in this one patch for v3.19. The SOCFPGA chip has
> a quirk that causes it to consume more power when CPU1 is put in reset
> instead of WFI when it is hot-unplugged. This patch fixes this issue.
> 
> Thanks,
> 
> The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:
> 
>   Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)
> 
> are available in the git repository at:
> 
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_update_for_v3.19
> 
> for you to fetch changes up to e15a11e885423aff12ed841677108fde4de40319:
> 
>   socfpga: hotplug: put cpu1 in wfi (2014-11-17 15:23:42 -0600)
> 
> ----------------------------------------------------------------
> SoCFPGA update for v3.19
> 
> Use WFI instead of putting CPU1 into reset will fix problem of increased
> power when unplugging CPU1.
> 

Since this is just one patch, I cherry-picked it on next/soc.

I was going to pull it, but it would force me to pull in 3.18-rc4, and
that doesn't seem worth it. Please just send pull requests based on -rc1
in the future.

	Arnd
