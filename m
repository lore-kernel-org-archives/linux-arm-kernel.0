From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jun 2014 11:18:34 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add QCOM GSBI driver
In-Reply-To: <1403081542-28291-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1403081542-28291-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <18174197.d6AsbBFpue@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 09:52:22 Srinivas Kandagatla wrote:
> This patch adds QCOM GSBI config option to multi_v7_defconfig. Serial
> driver on QCOM APQ8064 depends on GSBI driver, so without this patch
> there is no serial console on IF6410 board using multi_v7_defconfig.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Applied to fixes branch, thanks,

	Arnd
