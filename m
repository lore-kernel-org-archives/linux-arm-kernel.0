From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 May 2017 23:56:15 -0700
Subject: [GIT PULL 1/2] Broadcom devicetree changes for 4.12
In-Reply-To: <20170514033526.21260-1-f.fainelli@gmail.com>
References: <20170514033526.21260-1-f.fainelli@gmail.com>
Message-ID: <20170519065615.GA9628@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 08:35:25PM -0700, Florian Fainelli wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/devicetree-fixes
> 
> for you to fetch changes up to b155f05dc578299557447a6fd6545ebc72c1d19b:
> 
>   Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/fixes (2017-05-13 20:26:09 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC Device Tree fixes for
> 4.12, please pull the following:
> 
> - Baruch provides several fixes for the Raspberry Pi (BCM2835) Device
>   Tree source include file: uart0 pinctrl node names, pin number for
>   i2c0, uart0 rts/cts pins and invalid uart1 pin, missing numbers for
>   ethernet aliases

Thanks, merged.


-Olof
