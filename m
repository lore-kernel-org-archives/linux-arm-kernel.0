From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 17 Mar 2013 23:26:10 +0100
Subject: [GIT PULL 3/3] ARM: mvebu: soc for v3.10
In-Reply-To: <1363551341.10D8ED563.32562@triton>
References: <1363551341.10D8ED563.32562@triton>
Message-ID: <51464302.5000906@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 03/17/2013 09:15 PM, Jason Cooper wrote:
> The following changes since commit 207b6b8da3195dafe3e0d2143262640ddace74af:
> 
>   Merge branch 'mvebu/drivers' into mvebu/soc
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/soc_changes_for_v3.10
> 
> for you to fetch changes up to c135394ade12b00be1fdd04f68ff8470207a9b32:
> 
>   arm: plat-orion: remove addr-map code
> 
> ----------------------------------------------------------------
> mvebu soc changes for v3.10
>     
>      - use mvebu-mbus driver for:
>         - kirkwood
>         - dove
>         - orion5x
>         - mv78xx
>         - mvebu
>     
>      - depends
>         - tags/cleanup_for_v3.10 (mvebu/cleanup)
>         - tags/drivers_for_v3.10 (mvebu/drivers)
> ----------------------------------------------------------------
> Thomas Petazzoni (6):
>       arm: mach-mvebu: convert to use mvebu-mbus driver
>       arm: mach-kirkwood: convert to use mvebu-mbus driver
>       arm: mach-dove: convert to use mvebu-mbus driver
>       arm: mach-orion5x: convert to use mvebu-mbus driver
>       arm: mach-mv78xx0: convert to use the mvebu-mbus driver

Could you hold on this one?

I managed to test Thomas patch set for a mv78x00 based board on Friday,
and I found a small bug. Thomas has a fix for it and he plans to send
a V3 with this fix next week.

Thanks,

Gregory
