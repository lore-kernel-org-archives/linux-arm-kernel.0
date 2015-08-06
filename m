From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Aug 2015 09:28:27 +0200
Subject: [PATCH 0/9] LPC18xx DTS changes for 4.3 part2
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <20150806072827.GA22787@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 12:24:18AM +0200, Joachim Eastwood wrote:
> Here is some more LPC18xx dts changes for v4.3. This is the dts
> changes for the drivers that will go in for v4.3. Note that the
> USB phy driver is not in next yet, but is queued on Kishon's phy
> next repo.
> 
> Changes include:
> 
>  - Add USB OTG phy, PL111 LCD controller and PL172 memory
>    controller nodes to lpc18xx.dtsi
> 
>  - Enable USB0 on EA4357 Dev Kit
> 
>  - Add static memory devices on EA4357 Dev Kit
> 
>  - Enable UART0 pinmux and Ethernet on Hitex Eval Board
>    from Ariel D'Alessandro
> 
>  - Add static memory devices on Hitex Eval Board
> 
> Changes are also available in the git repository at:
> 
>   https://github.com/manabian/linux-lpc.git tags/lpc18xx_dts_for_4.3-part2

Thanks, I missed the pull request until I had already applied them directly.

Feel free to use the standard git request-pull format in the future. :)


-Olof
