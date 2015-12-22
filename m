From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:54:46 -0800
Subject: [GIT PULL 3/5] ARM: tegra: Core SoC changes for v4.5-rc1
In-Reply-To: <1450356639-7758-3-git-send-email-thierry.reding@gmail.com>
References: <1450356639-7758-1-git-send-email-thierry.reding@gmail.com>
 <1450356639-7758-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <20151222195446.GH30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 01:50:37PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.5-soc
> 
> for you to fetch changes up to a262e87ff354f12447bb6268bd63edf7ba1c20e0:
> 
>   ARM: tegra: select USB_ULPI from EHCI rather than platform (2015-11-24 16:47:26 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Core SoC changes for v4.5-rc1
> 
> The big thing here is Tegra210 support, which is really only the Kconfig
> symbol. Other than that there's a few miscellaneous fixes.

Hi,

We merge arch/arm and arch/arm64 and drivers/bus contents through separate
branches, so having them come in from you in one combined branch isn't working
very well.

If you don't have any downstream users of this I can just cherry-pick them into
the appropriate branches, but if you do, please send separate requests for
those three categories.


Thanks!


-Olof
