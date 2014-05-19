From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 May 2014 00:40:40 +0900
Subject: [PATCH v3 0/4] ARM: dts: enable display for peach-pit and snow
 boards
In-Reply-To: <1399630186-22610-1-git-send-email-rahul.sharma@samsung.com>
References: <1399630186-22610-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <537A25F8.4040604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/14 19:09, Rahul Sharma wrote:
> From: Rahul Sharma<Rahul.Sharma@samsung.com>

Probably, should be "Rahul Sharma <rahul.sharma@...>"

Please make sure your gitconfig has no problem.

Just note, I found same thing and fixed your email address in my tree...

>
> Add nodes for fimd and dp controller for exynos5250 based snow
> and exynos5420 based peach-pit board.
>
> This series is based on Kukjin Kims, for-next branch.
>
> V3:
> 1) Dropped 1 patch "ARM: dts: move dp hpd line to the board file for
>   exynos5420".
> 2) Extra blank lines for readability.
> 3) dp hpd gpio name change (dp_hpd ->  dp_hpd_gpio)
>
> V2:
> 1) Rebase on Peach-pit dependent patches.
>
> It is dependent on
> 1) Andrew Bresticker's patch for hpd gpio addition, avilable at
> http://www.spinics.net/lists/linux-samsung-soc/msg28827.html [Patch is 'ACK'ed.]
> 2) Arun's patch for adding peach-pit board dts file at
> http://www.spinics.net/lists/linux-samsung-soc/msg30103.html. [Patch is 'ACK'ed.]
>
> Rahul Sharma (4):
>    ARM: dts: enable fimd for exynos5250 based snow board
>    ARM: dts: enable dp-controller for exynos5250 based snow board
>    ARM: dts: enable fimd for exynos5420 based peach-pit board
>    ARM: dts: enable dp-controller for exynos5420 based peach-pit board
>
>   arch/arm/boot/dts/exynos5250-snow.dts      |   35 ++++++++++++++++++++++++
>   arch/arm/boot/dts/exynos5420-peach-pit.dts |   41 ++++++++++++++++++++++++++++
>   2 files changed, 76 insertions(+)
>
OK, applied whole series with Jingoo's 'reviewed-by'.

Thanks,
Kukjin
