From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 22 Apr 2016 12:24:28 -0700
Subject: [GIT PULL 1/2] bcm2835 DT changes for 4.7
In-Reply-To: <1461184067-31925-1-git-send-email-eric@anholt.net>
References: <1461184067-31925-1-git-send-email-eric@anholt.net>
Message-ID: <571A7A6C.4060205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/16 13:27, Eric Anholt wrote:
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/anholt/linux tags/bcm2835-dt-next-2016-04-20
> 
> for you to fetch changes up to 896ad420db8d5ec4cc4727b786d15e28eb59b366:
> 
>   dt/bindings: bcm2835: correct description for DMA-int (2016-04-19 17:31:58 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in VC4 devicetree support and the other minor
> DT changes for 4.7.
> 
> Also included is a DRM patch necessary to prevent regressions when
> simplefb and vc4 drivers are both present.  The patch was suggested by
> the simplefb maintainer as the solution agreed upon at ELCE 2014, and
> was acked by the DRM maintainer for merging through this tree.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Eric!
-- 
Florian
