From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 18:12:03 +0200
Subject: [GIT PULL 8/8] ARM: tegra: Default configuration updates for
 v4.2-rc1
In-Reply-To: <1431524980-13599-9-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
 <1431524980-13599-9-git-send-email-thierry.reding@gmail.com>
Message-ID: <16894539.kk24apyd4m@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 15:49:40 Thierry Reding wrote:
> ARM: tegra: Default configuration updates for v4.2-rc1
> 
> This is a set of changes to the Tegra default configuration that enable
> various new features (HDMI audio, watchdog) on Toradex Apalis T30.
> 

Applied into next/defconfig.

I noticed that you have not included the config options in
multi_v7_defconfig. Please check that all drivers you need
are also enabled in that generic configuration (as loadable
modules if possible), and send an update for that config as
well.

Thanks,

	Arnd
