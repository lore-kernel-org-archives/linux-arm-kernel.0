From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 11:41:01 +0200
Subject: [PATCH] ARM: configs: Enable cpufreq-cpu0 for multi_v7_defconfig
In-Reply-To: <1409486979-26869-1-git-send-email-broonie@kernel.org>
References: <1409486979-26869-1-git-send-email-broonie@kernel.org>
Message-ID: <3122457.yORdifPoE7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 31 August 2014 13:09:39 Mark Brown wrote:
> Many boards share the cpufreq-cpu0 driver meaning that if we enable it in
> multi_v7_defconfig we can get a reasonable amount of functional utility for
> systems and test coverage for a fairly small increase in kernel size.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> 

Do we need this in 3.17, or should it go in during the merge window?

	Arnd
