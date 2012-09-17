From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Sep 2012 19:11:50 -0700
Subject: [GIT PULL 06/10] ARM: tegra: implement CPU hotplug
In-Reply-To: <1347653181-19936-6-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
 <1347653181-19936-6-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120917021150.GJ19186@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 02:06:17PM -0600, Stephen Warren wrote:
> This branch implements CPU hot-plugging support for both Tegra20 and
> Tegra30. Portions of the implementation are contained in the clock
> driver, hence this branch is based on the common clock conversion in
> order to avoid duplicating work.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-cpu-hotplug


Pulled into next/soc. Thanks!


-Olof
