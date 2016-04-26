From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 13:37:15 +0200
Subject: [PULL REQUEST v3] ARM: OXNAS pull request for 4.7
In-Reply-To: <1461657981-22942-1-git-send-email-narmstrong@baylibre.com>
References: <1461657981-22942-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <53499338.xCg5O7lsm4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 10:06:21 Neil Armstrong wrote:
> This is the ARM pull request for the OXNAS platform.
> It also includes one-line change into irq-versatile-fpga.
> 
> The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:
> 
>   Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/superna9999/linux.git tags/ox810se-arm-v4.6-rc3
> 
> for you to fetch changes up to e557959d5599037899dd974f4a79419c664dcf79:
> 
>   MAINTAINERS: add maintainer entry for ARM/OXNAS platform (2016-04-26 09:50:53 +0200)
> 

Pulled into next/soc

Please include descriptions of the contents in each tag in the
future, so they can become the merge changelog text. This is what
I put in there myself:
    
    Merge "ARM: Add OXNAS Platform Support" from Neil Armstrong
    
    This is for the ARM926 based ox810 chip used in some older
    NAS appliances. There is another related ox820 chip based on
    ARM11 that might get added here later.


Thanks!

	Arnd
