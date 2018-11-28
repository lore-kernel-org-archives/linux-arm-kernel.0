From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Nov 2018 13:48:57 -0800
Subject: [GIT PULL 3/4] bcm2835-drivers-next-2018-11-27
In-Reply-To: <20181127211301.30296-3-eric@anholt.net>
References: <20181127211301.30296-1-eric@anholt.net>
 <20181127211301.30296-3-eric@anholt.net>
Message-ID: <43207cc2-da5d-863f-babd-9ce89722141e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/27/18 1:13 PM, Eric Anholt wrote:
> Hi Florian,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-drivers-next-2018-11-27
> 
> for you to fetch changes up to 502b431cda801645fd73857f7b47a4666de3cb62:
> 
>   firmware: raspberrypi: Switch to SPDX identifier (2018-11-21 14:33:11 +0100)
> 
> ----------------------------------------------------------------
> This pull request adds SPDX to BCM2835 drivers, and fixes some bugs in
> the firmware driver (silently hanging if the VPU doesn't respond to a
> mailbox transaction, and undersized buffers in the firmware property
> transactions for tags that aren't used yet in the upstream).
> 
> ----------------------------------------------------------------

Merged into drivers/next, thanks Eric.
-- 
Florian
