From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 18:01:37 -0700
Subject: [GIT PULL] Samsung fixes-1 for v3.10
In-Reply-To: <51795C62.8070500@samsung.com>
References: <51795C62.8070500@samsung.com>
Message-ID: <20130427010137.GD2350@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 01:40:02AM +0900, Kukjin Kim wrote:
> The following changes since commit 58a7bbf75442ea439a4d3b7993ad87023e406063:
> 
>   ARM: dts: add PDMA0 changes for exynos5440 (2013-04-09 01:39:27 +0900)

So these are fixes based on code that's already staged. We normally
don't do that -- if you have a fix for a specific branch that introduced
something, send a fresh pull request for that branch.

Looks like Doug's fix is for the common clock framework branch, so I'll apply
it to next/drivers. Thomas' is for the dt branch. I'll cherry-pick it onto
next/dt2.


-Olof
