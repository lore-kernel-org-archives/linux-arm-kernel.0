From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 16:48:09 +0200
Subject: [GIT PULL 1/5] i.MX cleanup for 4.9
In-Reply-To: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
Message-ID: <2273920.Db5AjnFSWq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2016 5:02:24 PM CEST Shawn Guo wrote:
> i.MX cleanup for 4.9:
>  - Drop i.MX1 board files and make i.MX1 a DT only platform.
>  - Remove obsolete ENET initialization code for TX28 board, since FEC
>    driver handles those setup well now.
>  - A couple of cleanups on i.MX31 IOMUX headers to drop duplications
>  - A few other random and trivial cleanups
> 

Pulled into next/cleanup, thanks!

	Arnd
