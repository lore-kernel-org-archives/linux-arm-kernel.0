From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 10:21:58 +0200
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for
 v3.18
In-Reply-To: <cover.1410396013.git.horms+renesas@verge.net.au>
References: <cover.1410396013.git.horms+renesas@verge.net.au>
Message-ID: <2746360.e5Qbnl0Vc0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 09:57:15 Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these fourth round of Renesas ARM based SoC DT updates for
> v3.18.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt3-for-v3.18,
> which you have already pulled.
> 

Pulled into next/dt, thanks!

There is one new warning I got in the for-next branch after the last round
of pull requests, in mackerel_defconfig:

arch/arm/mach-shmobile/pm-sh7372.c:116:33: warning: 'sh7372_pm_domains' defined but not used [-Wunused-variable]
 static struct rmobile_pm_domain sh7372_pm_domains[] = {
                                 ^

I haven't looked at it in detail, can you find out what caused it and
send a fix with your next round?

	Arnd
