From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Sep 2012 19:11:33 -0700
Subject: [GIT PULL 05/10] ARM: tegra: i2c driver enhancements mostly
 related to clocking
In-Reply-To: <1347653181-19936-5-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
 <1347653181-19936-5-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120917021133.GI19186@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 02:06:16PM -0600, Stephen Warren wrote:
> This branch contains a number of fixes and cleanups to the Tegra I2C
> driver related to clocks. These are based on the common clock conversion
> in order to avoid duplicating the clock driver changes before and after
> the conversion. Finally, a bug-fix related to I2C_M_NOSTART is included.
> 
> This branch is based on previous pull request tegra-for-3.7-common-clk.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit b4350f40f73b75efdceae3d9e04266979acabd8c:
> 
>   ARM: Tegra: Add smp_twd clock for Tegra20
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-drivers-i2c

Pulled into next/drivers given the acks from Wolfram. Thanks!


-Olof
