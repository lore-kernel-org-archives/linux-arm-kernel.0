From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 19:52:57 -0700
Subject: [GIT PULL] Samsung fixes-3 for v3.10
In-Reply-To: <519FF6DB.5040002@samsung.com>
References: <519FF6DB.5040002@samsung.com>
Message-ID: <CAOesGMjEESQ1a6V3AC2RqGQTwk++Zq2FwZVQT0C=ToP1gTwR3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 4:25 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
>
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-fixes-3
>
> for you to fetch changes up to 15f504f0c2038b9a0f1569c9ce34def61f0c65be:
>
>   ARM: SAMSUNG: Add names to fimd0 IRQ resources (2013-05-25 06:49:43 +0900)
>
> ----------------------------------------------------------------
> Fixes following for v3.10
> - to get usb2 working on the Chromebook with adding the
>   usb phy node for usb2 on exynos5250
> - supporting exynos4210 rev0 SoC
> - exynos5440 restart applying only to powered-on domains
> - drm-exynos probe failure with adding resource names to
>   fimd0 platform device

Pulled, thanks.

-Olof
