From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 22:34:04 -0800
Subject: [GIT PULL 2/2] Broadcom drivers changes for 4.16
In-Reply-To: <20171222001227.30625-2-f.fainelli@gmail.com>
References: <20171222001227.30625-1-f.fainelli@gmail.com>
 <20171222001227.30625-2-f.fainelli@gmail.com>
Message-ID: <20180105063404.mfhmq6kpufdgs5w6@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 04:12:27PM -0800, Florian Fainelli wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.16/drivers
> 
> for you to fetch changes up to f780429adfbc222a4d8a227a2a550ba627c7338b:
> 
>   soc: brcmstb: biuctrl: Move to early_initcall (2017-12-20 17:37:44 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM/ARM64 based SoCs drivers changes for
> 4.16, please pull the following:
> 
> - Arnd provides an update to the Raspberry Pi firmware interface and uses time64_t to
>   print the time to make it more future proof
> 
> - Florian provides a set of updates to make the Broadcom STB Bus Interface Unit code
>   work on newer ARM64-based chips, as well as perform the correct interface tuning
>   for these chips to reach the expected performance
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       firmware: raspberrypi: print time using time64_t
> 
> Florian Fainelli (10):
>       Merge tag 'bcm2835-drivers-next-2017-12-19' into drivers/next
>       dt-bindings: arm: Add entry for Broadcom Brahma-B53
>       dt-bindings: arm: brcmstb: Correct BIUCTRL node documentation
>       soc: brcmstb: Make CPU credit offset more parameterized
>       soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs
>       soc: brcmstb: biuctrl: Prepare for saving/restoring other registers
>       soc: brcmstb: biuctrl: Wire-up new registers
>       soc: brcmstb: biuctrl: Fine tune B53 MCP interface settings
>       soc: brcmstb: Split initialization
>       soc: brcmstb: biuctrl: Move to early_initcall

Merged, thanks.

Btw, you're sort of bare on signatures for your pgp key. You should try
to get at least me or Arnd to sign it at some point, hopefully we'll
overlap at conferences sometime. I've probably already offered once,
but seems I didn't actually upload my signature when I did it.


-Olof
