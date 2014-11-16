From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Nov 2014 15:10:48 -0800
Subject: [GIT PULL] omap fixes against v3.18-rc4
In-Reply-To: <20141111165357.GB26481@atomide.com>
References: <20141111165357.GB26481@atomide.com>
Message-ID: <20141116231048.GC14929@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 08:53:58AM -0800, Tony Lindgren wrote:
> The following changes since commit 4b91f7f3c8b20e073b7bfc098625b37f99789508:
> 
>   ARM: OMAP2+: Warn about deprecated legacy booting mode (2014-10-29 12:19:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-against-v3.18-rc4
> 
> for you to fetch changes up to 73b3a6657a88ef5348a0d69c9a8107d6f01ae862:
> 
>   pinctrl: dra: dt-bindings: Fix output pull up/down (2014-11-10 14:29:20 -0800)
> 
> ----------------------------------------------------------------
> Few omap fixes for hangs and wrong pinctrl defines, and update
> MAINTAINERS file to avoid missing PMIC and SoC related patches:
> 
> - Fix random hangs on am437x because of incorrect default
>   value for the DDR regulator
> 
> - Fix wrong partition name for NAND on am335x-evm
> 
> - Fix wrong pinctrl defines for dra7xx
> 
> - Update maintainers entries for PMICs and SoCs

Merged. Might miss today's -rc though.


-Olof
