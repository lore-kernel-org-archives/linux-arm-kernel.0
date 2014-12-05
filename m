From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Dec 2014 11:13:03 +0100
Subject: [PATCH v3 1/8] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT6397 SoC
In-Reply-To: <1417752479-4749-2-git-send-email-flora.fu@mediatek.com>
References: <1417752479-4749-1-git-send-email-flora.fu@mediatek.com>
 <1417752479-4749-2-git-send-email-flora.fu@mediatek.com>
Message-ID: <2751641.o51TuZRl88@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 December 2014 12:07:52 Flora Fu wrote:
> Add PMIC wrapper of MT8135 to access MT6397 MFD.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> 

Please explain what a PMIC wrapper is and why you need one for MT8135.
I don't understand the purpose of this code at all. Is this just another
way of accessing the MT6397 when not using i2c or spi like other
PMIC drivers do?

	Arnd
