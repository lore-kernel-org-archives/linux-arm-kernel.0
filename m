From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 13:55:02 -0700
Subject: [GIT PULL 0/5] ARM: samsung/exynos: Stuff for v4.18
In-Reply-To: <20180513154238.22508-1-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org>
Message-ID: <20180514205502.u25kugxkym4tz34e@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 05:42:33PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes for v4.18. No dependencies, no specific order of pulls.
> 
> Support for Exynos5440 is removed step by step through different trees.

5440 was always a bit of a weird fit, it clearly was never an exynos5-family
platform. I take it there are no substantial users left that would need
mainline kernel support for it?

Also, I noticed your PGP key has expired, so you should probably start
collecting signatures on a fresh subkey.


-Olof
