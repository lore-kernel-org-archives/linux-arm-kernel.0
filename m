From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 Oct 2015 10:14:35 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add missing QCOM APQ8064 configs
In-Reply-To: <1443704258-3180-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443704258-3180-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <7133797.1AP9OuVQ6T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 October 2015 13:57:38 Srinivas Kandagatla wrote:
> This patch adds few missing essential configs in the multi_v7_defconf,
> absense of some configs like PINCTRL_APQ8064 would prevent the board from
> getting access to serial.
> 
> cc: Kevin Hilman <khilman@kernel.org>
> cc: Tyler Baker <tyler.baker@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Can you make some of these '=m' instead of '=y'? We try to have most things
that are not essential for booting as loadable modules, so the kernel
doesn't get too big.

	Arnd
