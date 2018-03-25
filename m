From: ctatlor97@gmail.com (Craig Tatlor)
Date: Sun, 25 Mar 2018 20:33:41 +0100
Subject: [v9,04/15] clk: qcom: Add HFPLL driver
In-Reply-To: <520347148-27852-5-git-send-email-sricharan@codeaurora.org>
References: <520347148-27852-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180325193341.27845-1-ctatlor97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This doesn't seem to work correctly with the higher clocks on 8974pro, specifically 2150400000 hz or above, maybe its something to do with being bigger than an unsigned long.

When i try to set any higher frequency it jumps down to 300mhz.
