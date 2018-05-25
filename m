From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 13:47:56 -0700
Subject: [GIT PULL 2/5] i.MX SoC changes for 4.18
In-Reply-To: <1526828281-14664-2-git-send-email-shawnguo@kernel.org>
References: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
 <1526828281-14664-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20180525204756.2x2xec4azdp5362r@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 10:57:58PM +0800, Shawn Guo wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.18
> 
> for you to fetch changes up to 0e8d1c4b7613399494720e315f99d21793cacb8c:
> 
>   ARM: imx: select imx6sll pinctrl when imx6sll enabled (2018-05-02 15:01:32 +0800)
> 
> ----------------------------------------------------------------
> i.MX SoC update for 4.18:
>  - A series from Bartosz to convert all i.MX plaform code using
>    at24_platform_data to use at24 eeprom generic device properties.
>  - Enable pinctrl driver support for i.MX6SLL SoC.
>  - Clean up i.MX platform code using spi_imx platform data on outdated
>    documentation and chip select array usage.

Merged, thanks!


-Olof
