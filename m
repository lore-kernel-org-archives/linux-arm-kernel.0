From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Oct 2015 11:33:54 -0700
Subject: [GIT PULL] DT changes for BCM2835 for 4.4
In-Reply-To: <87pp0gotdf.fsf@eliezer.anholt.net>
References: <87pp0gotdf.fsf@eliezer.anholt.net>
Message-ID: <56253792.9090000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 11:54, Eric Anholt wrote:
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/anholt/linux tags/bcm2835-dt-for-4.4-v1
> 
> for you to fetch changes up to 9450d58953f947ecb666e552096d6faa3476f71d:
> 
>   ARM: bcm2835: Switch to using the new clock driver support. (2015-10-14 15:41:20
> -0700)
> 
> ----------------------------------------------------------------
> This pull request contains the DT changes for BCM2835 in 4.4.  It
> pulls in clk/clk-bcm2835 (which Stephen Boyd has said would be stable)
> because the DT changes to enable the clock driver need the driver
> itself to be present.

Applied to devicetree/next, thanks!
-- 
Florian
