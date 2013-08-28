From: olof@lixom.net (Olof Johansson)
Date: Wed, 28 Aug 2013 16:58:55 -0700
Subject: [GIT PULL] at91: soc update for 3.12 #1
In-Reply-To: <1377532543-349-1-git-send-email-nicolas.ferre@atmel.com>
References: <1377532543-349-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20130828235855.GM8607@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 05:55:43PM +0200, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> Here is AT91 SoC updates for 3.12 kernel. It is the first pull-request for
> this topic and it is based on 3.11-rc5 like your next/soc branch.
> 
> Thanks, best regards,
> 
> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
> 
>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-soc
> 
> for you to fetch changes up to 99eb3b40ec42e7fce1fc58429bf9b26c17973c12:
> 
>   ARM: at91: at91_dt_defconfig: enable rm9200 support (2013-08-26 09:58:29 +0200)
> 
> ----------------------------------------------------------------
> AT91 SoC update for 3.12 take 1
> - enable kernel uncompress information output for
>   SoC where it was missing: at91sam9n12 and sama5d3
> - addition of at91rm9200 to the generic at91_dt_defconfig
> 
> ----------------------------------------------------------------
> Jean-Christophe PLAGNIOL-VILLARD (1):
>       ARM: at91: at91_dt_defconfig: enable rm9200 support
> 
> voice (4):
>       ARM: at91: sama5d3: add definition for usart base address
>       ARM: at91: include sama5d3.h into hardware.h
>       ARM: at91: sama5: enable kernel uncompress info output
>       ARM: at91: sam9n12: enable kernel uncompress info output

That doesn't look right. Author should probably be "Bo Shen
<voice.shen@atmel.com>" instead. Can you fixup and respin, please?


-Olof
