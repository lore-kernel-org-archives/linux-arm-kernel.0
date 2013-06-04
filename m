From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  4 Jun 2013 23:05:11 +0800
Subject: [PATCH v2 0/6] support hi3xxx soc
Message-ID: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v2:
1. Reuse mux & divider driver. So append CLK_MUX_HIWORD_MASK &
CLK_DIVIDER_HIWORD_MASK for Hi3620 SoC.
2. Fix system timer running too fast because wrong divider is choosen.
3. Remove .init_irq in DT machine descriptor.
