From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 16:05:17 +0200
Subject: [PATCH v2] ARM: multi_v7_defconfig: Add missing QCOM APQ8064
 configs
In-Reply-To: <1444036342-7900-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444036342-7900-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <5528809.bEU3IH1PSo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 October 2015 10:12:22 Srinivas Kandagatla wrote:
> This patch adds few missing essential configs in the multi_v7_defconf,
> absense of some configs like PINCTRL_APQ8064 would prevent the board from
> getting access to serial.
> 
> cc: Kevin Hilman <khilman@kernel.org>
> cc: Tyler Baker <tyler.baker@linaro.org>
> Tested-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 

Merged into next/defconfig, thanks!

	Arnd
