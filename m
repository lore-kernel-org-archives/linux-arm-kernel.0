From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Apr 2013 09:35:14 +0200
Subject: [PATCH 2/4] arm64: Initial defconfig for APM X-Gene SOC family
In-Reply-To: <1366442131-26094-3-git-send-email-vkale@apm.com>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <1366442131-26094-3-git-send-email-vkale@apm.com>
Message-ID: <2165570.9Zy5vrhoIa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 April 2013 12:45:29 Vinayak Kale wrote:
> This patch adds initial defconfig for APM X-Gene SOC family.
> 
> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  arch/arm64/configs/xgene_defconfig |   93 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 93 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm64/configs/xgene_defconfig

Could you modify the regular defconfig to enable everything you need instead
of adding another one? Since all the code is interoperable, I think we
should not need a defconfig per soc.

	Arnd
