From: ben-i2c@fluff.org (Ben Dooks)
Date: Wed, 7 Sep 2011 00:15:20 +0100
Subject: [PATCH REPOST 0/3] i2c: tegra: Outstanding patches
In-Reply-To: <1314726370-8193-1-git-send-email-swarren@nvidia.com>
References: <1314726370-8193-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110906231520.GB25655@freya.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 11:46:07AM -0600, Stephen Warren wrote:
> For convenience, here's a repost of the outstanding patches for the Tegra
> I2C driver.

applied all of them.

in future, it would be helpful to have just i2c-tegra on the
front of the subject. fixed these up and put them in pull req
to linus
 
> Doug Anderson (1):
>   i2c: tegra: fix possible race condition after tx
> 
> John Bonesio (1):
>   i2c: Tegra: Add of_match_table
> 
> Mike Rapoport (1):
>   i2c: i2c-tegra: add I2C_FUNC_SMBUS_EMUL
> 
>  drivers/i2c/busses/i2c-tegra.c |   60 ++++++++++++++++++++++++++++++----------
>  1 files changed, 45 insertions(+), 15 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
