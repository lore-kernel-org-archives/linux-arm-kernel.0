From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Feb 2016 12:22:35 -0800
Subject: [GIT PULL] at91: fixes for 4.5 #1
In-Reply-To: <1453972115-25776-1-git-send-email-nicolas.ferre@atmel.com>
References: <1453972115-25776-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160201202235.GG13508@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 10:08:35AM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> First AT91 fixes pull-request for 4.5, all DT modifications. The bulk of the
> changes is about adding the phy specification to Ethernet nodes because of
> recent changes in phy drivers that tend to require a comprehensive description
> of the Ethernet hardware.
> It is based on 4.5-rc1 to prevent merging issues.
> 
> Thanks, best regards,
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes
> 
> for you to fetch changes up to e873cc022ce5e2c04bbc53b5874494b657e29d3f:
> 
>   ARM: dts: at91: sama5d4 xplained: fix phy0 IRQ type (2016-01-27 11:14:25 +0100)

Thanks, merged.


-Olof
