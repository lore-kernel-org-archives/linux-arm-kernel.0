From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 17:44:33 +0200
Subject: [GIT PULL 2/3] ARM: berlin: DT changes for v4.4 (round 1)
In-Reply-To: <1444416494-3117-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1444416494-3117-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1444416494-3117-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <6053924.4novCdxIMG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 20:48:13 Sebastian Hesselbarth wrote:
> this is round 1 of Marvell Berlin DT changes for v4.4. There is
> some improvement in serial aliases/stdout path, cpufreq properties,
> and PWM nodes for all SoCs. The cpufreq properties depend on cpuclk
> being available, therefore this branch has a dependency with the
> cpuclk topic PR sent earlier.
> 

Pulled into next/dt, thanks!

	Arnd
