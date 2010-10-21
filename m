From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 22 Oct 2010 00:55:19 +0800
Subject: [PATCH v2] babbage: esdhc device registration
Message-ID: <1287680120-11354-1-git-send-email-shawn.gsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update commit message to address Amit Kucheria's review comment.

This patch is to add esdhc device registration for babbage board.
And it depends on Eric B?nard's patchset below.

 - cpuimx51: update board support
 - clock-mx51: factorize clk_set_parent and clk_get_rate
 - imx-esdhc: update devices registration
