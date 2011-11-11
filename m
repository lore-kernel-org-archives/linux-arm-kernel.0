From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 09:10:15 +0800
Subject: [PATCH V2 00/14] add clk_prepare/clk_unprepare to imx drivers
Message-ID: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from V1:
 - Add common helper functions clk_prepare_enable/clk_disable_unprepare
 - serial/imx: move clk_disable_unprepare before clk_put

Thanks
Richard
