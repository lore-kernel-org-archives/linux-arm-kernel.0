From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 12:54:48 +0100
Subject: [GIT PULL 3.19] Broadcom Cygnus SoC Device Tree changes
In-Reply-To: <1415826266-6867-2-git-send-email-f.fainelli@gmail.com>
References: <1415826266-6867-1-git-send-email-f.fainelli@gmail.com>
 <1415826266-6867-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <201411201254.48494.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014, Florian Fainelli wrote:
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/brcm/linux.git tags/arm-soc/for-3.19/cygnus-dts-v2
> 
> for you to fetch changes up to c9ad7bc5fe3c57c8c817fcb1bd264a02176a40c4:
> 
>   ARM: dts: Enable Broadcom Cygnus SoC (2014-11-11 22:30:42 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains the Broadcom Cygnus Device Tree changes:
> 
> - binding documentation for the SoC and clock
> - cygnus SoC and clock dtsi files
> - DTS for Cygnus Entreprise phone, BCM911360K and BCM958300K

Something went wrong here: This branch contains the updated license
statements, but Olof had already merged the branch with the original
license statements that we didn't like, so all three patches conflict
with the ones we already have.

I've done an merge of the new branch over the old one, which was
literally the first thing in the next/dt branch. This isn't ideal,
but I think it's the best way out of the mess.

I hope we can avoid this in the future.

	Arnd
