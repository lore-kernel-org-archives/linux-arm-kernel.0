From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jan 2016 20:31:01 +0100
Subject: [PATCH v3 6/9] ARM: dts: rockchip: add the sdio power sequence
 for kylin board
In-Reply-To: <1452865796-23527-7-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <1452865796-23527-7-git-send-email-wxt@rock-chips.com>
Message-ID: <10023420.T8auvzlYRp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Januar 2016, 21:49:53 schrieb Caesar Wang:
> This patch adds the sdio power sequence for kylin board.
> The WLAN attached to a SDIO interface, wifi/bluetooth have
> reset and power been needed to enable.
> 
> AFAIK, the simple power sequence provider sets a value for multiple GPIOs.
> So the reset and power of WlAN chip can be handled in mmc power sequence.
> On the module itself this is one of these, that should can be handled by
> reset GPIOs in simple mmc power sequence.
> 
> The Bluetooth host wake is high active from bootup, this patch is also
> set pinctrl bias as the default to enable the pull up in soc internal.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts32 branch for 4.6,

after moving the sdio-pwrseq node to its correct alphabetical position. 
Please try to keep to the sorting :-)


Thanks
Heiko
