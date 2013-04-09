From: kgene.kim@gmail.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 23:55:08 +0900
Subject: [GIT PULL 06/10] 2nd pinctrl-exynos for v3.10
In-Reply-To: <51630A18.6010801@samsung.com>
References: <51630A18.6010801@samsung.com>
Message-ID: <51642BCC.6000200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/13 03:19, Kukjin Kim wrote:
> The following changes since commit
> 97916777d6904e24b86eac77da58ef7cb09d539d:
>
> ARM: EXYNOS: skip wakeup interrupt registration for exynos5250 if
> pinctrl is enabled (2013-03-05 20:59:12 +0900)
>
> are available in the git repository at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/pinctrl-exynos-for-v3.10
>
> for you to fetch changes up to 790af0a51bdcbf504814be2673f96facfdd74981:
>
> pinctrl: exynos5440: add gpio interrupt support (2013-04-08 23:55:41 +0900)
>
> ----------------------------------------------------------------
> add support gpio interrupt for exynos5440
>
> ----------------------------------------------------------------
> Thomas Abraham (2):
> pinctrl: exynos5440: fix probe failure due to missing pin-list in config
> nodes
> pinctrl: exynos5440: add gpio interrupt support
>
> drivers/pinctrl/pinctrl-exynos5440.c | 151
> ++++++++++++++++++++++++++++++++++-
> 1 file changed, 148 insertions(+), 3 deletions(-)
>

Hi Arnd, Olof

Please hold on this pulling because this already merged into pinctrl tree.

Thanks.

- Kukjin
