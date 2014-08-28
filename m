From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Aug 2014 14:49:52 +0200
Subject: [PATCH] ARM: shmobile: Enable Armadillo 800 EVA board in
 multiplatform defconfig
In-Reply-To: <1409229622-11566-1-git-send-email-geert+renesas@glider.be>
References: <1409229622-11566-1-git-send-email-geert+renesas@glider.be>
Message-ID: <3285079.8x1UeyRQTp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 August 2014 14:40:22 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/configs/shmobile_defconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

No objections to the patch, but I wonder if you could send another
patch to enable all the machines working in ARCH_SHMOBILE_MULTI
as part of multi_v7_defconfig as well.

	Arnd
