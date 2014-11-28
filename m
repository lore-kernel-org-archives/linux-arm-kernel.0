From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 22:40:20 +0100
Subject: [GIT PULL v2] ARM: BCM5301X: DT changes for v3.19
In-Reply-To: <54779999.8020709@hauke-m.de>
References: <54779999.8020709@hauke-m.de>
Message-ID: <201411282240.20360.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014, Hauke Mehrtens wrote:
> Hi Olof, Hi Arnd,
> 
> Please consider these BCM5301X ARM based SoC dt updates for v3.19.
> 
> This is the second try based on 3.18-rc1 and without the early printk patch.
> 
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/hauke/linux.git tags/bcm5301x-dt-2014-11-27
> 
> for you to fetch changes up to dd6d2e5f4bbb828268506e9d6b772fffe101e76c:
> 
>   ARM: BCM5301X: Add LEDs for Netgear R6250 V1 (2014-11-27 22:30:32 +0100)
> 
> ----------------------------------------------------------------
> ARM: BCM5301X: Add some more devices to device tree
> 
> The most important part is adding the axi bus to the SoC dtsi file,
> this is the main bus on the SoC.
> 
> These patches were all send to the arm list and I haven't got any
> negative responses.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Pulled into next/dt, thanks!

	Arnd
