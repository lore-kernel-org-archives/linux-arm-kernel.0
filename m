From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 20 Nov 2012 13:38:39 +0900
Subject: [PATCH] ARM: EXYNOS: Add support for ORIGEN4QUAD board
In-Reply-To: <1353345846-31355-1-git-send-email-kh.choi@insignal.co.kr>
References: <1353345846-31355-1-git-send-email-kh.choi@insignal.co.kr>
Message-ID: <0b6801cdc6d8$e98c1600$bca44200$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chlrbgh0 at gmail.com wrote:
> 
> From: Kyuho Choi <kh.choi@insignal.co.kr>
> 
> This patch add support for Insignal ORIGEN4QUAD board.
> ORIGEN4QUAD board based on Samsung Exynos4412 SoC.
> 
> Signed-off-by: Kyuho Choi <kh.choi@insignal.co.kr>
> ---
>  arch/arm/mach-exynos/Kconfig       |    1 +
>  arch/arm/mach-exynos/mach-origen.c |   74
+++++++++++++++++++++++++++-----
> ---
>  2 files changed, 58 insertions(+), 17 deletions(-)
> 
Hmm...at this moment, I don't want to update non-DT stuff for exynos,
because I have a plan to move on supporting only DT for all of exynos next
time.

Please submit DT patches for the ORIGEN4QUAD board.

Thanks.

K-Gene <kgene@kernel.org>
