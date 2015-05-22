From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 17:15:36 +0200
Subject: [GIT PULL] Samsung related to updating multi_v7_defconfig
In-Reply-To: <555D4BF5.20008@kernel.org>
References: <555D4BF5.20008@kernel.org>
Message-ID: <2227456.dXyEpqfCYe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 12:07:33 Kukjin Kim wrote:
> 
> Here is multi_v7_defconfig update and mostly including regarding exynos
> stuff based on savedefconfig which could remove useless configs based on
> checking of dependencies.
> 
> This series is based on v4.1-rc1 and I can provide resolution of
> conflicts with arm-soc/next/defconfig. See below.
> 
> Note that, IMHO we need to check 'savedefconfig when defconfig is
> updated so that we could remove useless lines and avoid to miss some
> defconfigs because of dependency.
> 
> Anyway please pull and if any concerns, please kindly let me know.
> 
> 

The conflict got a little too wild for my taste, so I dropped your
'savedefconfig' commit and rebased the other ones on top of the
branch I already had.

Please check that the result is still ok for you.

	Arnd
