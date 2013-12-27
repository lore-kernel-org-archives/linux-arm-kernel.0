From: olof@lixom.net (Olof Johansson)
Date: Fri, 27 Dec 2013 13:11:01 -0800
Subject: [GIT PULL 1/2] ARM: tegra: second set of device tree changes
In-Reply-To: <1387562844-32497-1-git-send-email-swarren@wwwdotorg.org>
References: <1387562844-32497-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131227211101.GA17637@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 11:07:23AM -0700, Stephen Warren wrote:
> This branch contains changes to Tegra's device tree that came in after
> I sent the previous pull-request/tag tegra-for-3.14-dt. Changes are:
> 
> * Set up aliases for RTCs, so that the correct RTC is chosen to
>   initialize the system date/time.
> * Venice2 pinctrl and regulator configuration.
> * Built-in panel enablement for Harmony, Cardhu, Dalmore.
> * HDMI enablement for Dalmore.
> * USB2 port enablement for Beaver.
> * Keyboard and power key enablement for Venice2.
> 
> This branch is based on tag tegra-for-3.14-dt, for which I sent a
> previous pull request.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 9f1ac5606a008f4849208ebfe818f979619dced0:
> 
>   ARM: tegra: Add SPI controller nodes for Tegra124
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.14-dt-2
> 
> for you to fetch changes up to 3f748d44503bd7ead26acf938f5a0bf845cea515:
> 
>   ARM: tegra: Enable power key on Venice2

Merged into next/dt. Thanks.


-Olof
