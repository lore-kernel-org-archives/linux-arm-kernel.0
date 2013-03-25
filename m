From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 11:36:36 +0000
Subject: EXYNOS will support only DT from v3.10
In-Reply-To: <17a501ce2948$17037610$450a6230$%kim@samsung.com>
References: <17a501ce2948$17037610$450a6230$%kim@samsung.com>
Message-ID: <201303251136.36542.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Kukjin Kim wrote:
> 
> Hi all,
> 
> As we discussed before, it's time to decide to support non-DT for EXYNOS
> SoCs.
> 
> If everybody else agrees to drop non-DT support from v3.10, I will. Feel
> free to talk your opinion about that.

+1

That will certainly simplify enabling multiplatform support as well.
I still have my series that I did recently for multiplatform support,
but I guess we need to coordinate better. Do you have a branch that
I can rebase on? There are still a couple of open questions in my
patches that I'd like to resolve as soon as possible.

	Arnd
