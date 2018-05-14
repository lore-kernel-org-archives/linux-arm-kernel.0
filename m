From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 13:50:47 -0700
Subject: [GIT PULL 2/5] soc: samsung: Stuff for v4.18
In-Reply-To: <20180513154238.22508-3-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org>
 <20180513154238.22508-3-krzk@kernel.org>
Message-ID: <20180514205047.3ni3agyc3a2vwy67@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 05:42:35PM +0200, Krzysztof Kozlowski wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.18
> 
> for you to fetch changes up to b2b568c591ddbb20d597e256212579d70dbf3000:
> 
>   soc: samsung: pm_domains: Deprecate support for clocks (2018-04-17 17:25:42 +0200)
> 
> ----------------------------------------------------------------
> Samsung soc drivers changes for v4.18
> 
> 1. Clock operations during power domain on/off were moved to respective
>    clock driver so clean up obsolete code from power domain driver.

Merged, thanks.


-Olof
