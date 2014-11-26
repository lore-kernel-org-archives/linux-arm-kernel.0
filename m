From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 27 Nov 2014 02:49:40 +0900
Subject: [PATCHv3 0/3] ARM: dts: add the support of Exynos3250-based Monk
 board
In-Reply-To: <1416826670-29438-1-git-send-email-cw00.choi@samsung.com>
References: <1416826670-29438-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <547612B4.8000909@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/14 19:57, Chanwoo Choi wrote:
> This patchset adds the support of Exynos3250-based Monk board and Exynos-based
> boards compatible string and description to remove build warning. Also, this
> patchset includes a patch which remove unused dt node for command line in
> Exynos3250-based Rinato dts file.
> 
> Changes from v2:
> - Include new patches by Chanwoo Choi with following patch[1]
>   [1] http://www.spinics.net/lists/arm-kernel/msg368443.html
> 
> Changes from v1:
> - Fix minor issue
> 
> Chanwoo Choi (2):
>   ARM: exynos: Add Exynos-based boards compatible string and description
>   ARM: dts: Remove unused command line from Exynos3250-based Rinato board
> 
> Youngjun Cho (1):
>   ARM: dts: add board dts file for Exynos3250-based Monk board
> 
>  .../devicetree/bindings/arm/samsung-boards.txt     |  19 +-
>  arch/arm/boot/dts/Makefile                         |   3 +-
>  arch/arm/boot/dts/exynos3250-monk.dts              | 579 +++++++++++++++++++++
>  arch/arm/boot/dts/exynos3250-rinato.dts            |   4 -
>  4 files changed, 595 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos3250-monk.dts
> 
Applied, thanks.

- Kukjin
