From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 23:17:34 -0700
Subject: [PATCH v2 08/21] clk: bcm2835: use match_string() helper
In-Reply-To: <1527765086-19873-9-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-9-git-send-email-xieyisheng1@huawei.com>
Message-ID: <152792025405.225090.5224138914235298506@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Yisheng Xie (2018-05-31 04:11:13)
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---

Applied to clk-next
