From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 00:55:05 +0200
Subject: [GIT PULL] MAINTAINERS update for Broadcom SoCs for 4.1
In-Reply-To: <1428692422-18369-1-git-send-email-f.fainelli@gmail.com>
References: <1428692422-18369-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <201504140055.05789.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 April 2015, Florian Fainelli wrote:
> The following changes since commit f22e6e847115abc3a0e2ad7bb18d243d42275af1:
> 
>   Linux 4.0-rc7 (2015-04-06 15:39:45 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/broadcom/stblinux tags/arm-soc/for-4.1/maintainers
> 
> for you to fetch changes up to 90a604a9ce881290fdc7468df4ca4e9c2ae4de62:
> 
>   MAINTAINERS: Update brcmstb entry (2015-04-10 11:52:40 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains 3 changes to the MAINTAINERS file for Broadcom SoCs:
> 
> - add Ray and Scott for mach-bcm
> - remove Christian for mach-bcm
> - remove Marc for brcmstb

I tried to pull these, but it would merge in 4.0-rc7, which I don't want to
do at this point. I also tried to cherry-pick the changes into
next/fixes-non-critical, which in turn conflicted with the earlier patch
that removes Matt as a maintainer.

Not worth trying anything fancy I think, please re-submit these based on
4.1-rc1.

	Arnd
