From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 3 Aug 2011 18:57:37 +0530
Subject: [PATCH v3] davinci: Add wl1271/wlan support for AM18x
In-Reply-To: <1311886373-3060-1-git-send-email-ido@wizery.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEC2@dbde02.ent.ti.com>
	<1311886373-3060-1-git-send-email-ido@wizery.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DF05D8E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ido,

On Fri, Jul 29, 2011 at 02:22:53, Ido Yariv wrote:
> The wl1271 daughter card for AM18x EVMs is a combo wireless connectivity
> add-on card, based on the LS Research TiWi module with Texas
> Instruments' wl1271 solution.
> It is a 4-wire, 1.8V, embedded SDIO WLAN device with an external IRQ
> line and is power-controlled by a GPIO-based fixed regulator.
> 
> Add support for the WLAN capabilities of this expansion board.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>

Can you please rebase this patch to master branch of my
tree[1] and repost. It doesn't apply at the moment.

Also, when you repost, please change the subject to

"ARM: davinci: AM18x: Add wl1271/wlan support"

so that it is consistent with other patches.

Thanks,
Sekhar

[1] git://gitorious.org/linux-davinci/linux-davinci.git
