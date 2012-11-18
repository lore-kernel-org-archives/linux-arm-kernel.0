From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Nov 2012 08:32:48 +0900
Subject: Final call for 3.8 arm-soc patches
In-Reply-To: <201211162111.34615.arnd@arndb.de>
References: <201211162111.34615.arnd@arndb.de>
Message-ID: <097e01cdc5e5$04d6a190$0e83e4b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> We are currently at linux-3.7-rc5, which means the merge window is coming
> closer.

Thanks for your gentle reminder.

> coming (tegra, clps711x, bcm), but I don't know what the status for some
> of the bigger ones (exynos/s5p/s3c, mvebu/orion, pxa/mmp). If you have
> more patches coming, please send all remaining pull requests soon, or

Yeah, there are patches for samsung stuff in my tree for 3.8 and I had a
plan to send it to arm-soc in the beginning of this week ;-) I will send
soon, probably by tomorrow.

> let us know what is holding you up.

I have new exynos5440(Quad Cortex-A15) patches and I'm holding it up due to
dependency of Samsung common clock stuff is under reviewing in mailing list.
I will apply exynos5440 stuff without Samsung common clock so that it can be
sent to upstream for v3.8.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
