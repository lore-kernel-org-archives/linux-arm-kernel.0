From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 18:09:20 +0200
Subject: [GIT PULL 7/8] ARM: tegra: Devicetree changes for v4.2-rc1
In-Reply-To: <1431524980-13599-8-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
 <1431524980-13599-8-git-send-email-thierry.reding@gmail.com>
Message-ID: <3095273.etWfHSyyvC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 15:49:39 Thierry Reding wrote:
> ARM: tegra: Devicetree changes for v4.2-rc1
> 
> Contains a couple of fixes and additions to device tree files. The most
> notable change is a fix for a misapplied patch that was only exposed by
> a recent change in the regulator subsystem that caused USB to break on
> Tegra124 recently.

It sounds like I should merge commit a4b6916cb35 ("ARM: tegra: Correct
which USB controller has the UTMI pad registers") into the 4.1 fixes
branch as well. Please confirm.

> Other than that there are a more or less random assortment of additions
> to enable various features on a couple of boards.
> 

Pulled into next/dt, thanks!

	Arnd
