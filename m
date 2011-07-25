From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 25 Jul 2011 18:53:51 +0530
Subject: [PATCH v2 5/6] arm: davinci: DA850: Add GPIO pinmux
	configuration for	wl1271
In-Reply-To: <1310303679-17936-6-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
	<1310303679-17936-6-git-send-email-ido@wizery.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CE12@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 18:44:38, Ido Yariv wrote:
> The wl1271 daughter board makes use of a few GPIOs:
> GPIO6_9 is used for powering down/up the WLAN functionality.
> GPIO6_10 is used as an input IRQ line from the WLAN chip.
> 
> Add the required pinmux configuration for these GPIOs.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>

4/6 and 5/6 both look good, will queue for v3.2/features

Thanks,
Sekhar
