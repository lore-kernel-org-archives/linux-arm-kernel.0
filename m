From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Dec 2015 09:52:45 +0100
Subject: [PATCH 2/4] soc: mediatek: Init MT8173 scpsys driver earlier
In-Reply-To: <1451457706-14798-3-git-send-email-jamesjj.liao@mediatek.com>
References: <1451457706-14798-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451457706-14798-3-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1670989.QknqqsXE3p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 December 2015 14:41:44 James Liao wrote:
> Some power domain comsumers may init before module_init.
> So the power domain provider (scpsys) need to be initialized
> earlier too.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
> 

Why?

	Arnd
