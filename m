From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Oct 2016 20:34:14 +0300
Subject: [PATCH v9 1/2] ARM: dts: Add TOPEET itop core board SCP package
 version
In-Reply-To: <1476811129-4450-2-git-send-email-ayaka@soulik.info>
References: <devicetree@vger.kernel.org>
 <1476811129-4450-1-git-send-email-ayaka@soulik.info>
 <1476811129-4450-2-git-send-email-ayaka@soulik.info>
Message-ID: <20161018173414.GA30003@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 01:18:48AM +0800, Randy Li wrote:
> The TOPEET itop is a samsung exnynos 4412 core board, which have
> two package versions. This patch add the support for SCP version.
> 
> Currently supported are USB3503A HSIC, USB OTG, eMMC, rtc and
> PMIC. The future features are in the based board. Also MFC and
> watchdog have been enabled.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 501 ++++++++++++++++++++++++
>  1 file changed, 501 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi


Thanks, applied, with minor changes in commit msg and fix in pin
function (you used macro for pull up/down instead of function).

Best regards,
Krzysztof
