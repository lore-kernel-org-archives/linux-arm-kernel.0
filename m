From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 19 Dec 2013 12:45:07 +0100
Subject: [PATCH 6/7] clk/samsung: add support for pll2650xx
In-Reply-To: <1386345391-23482-7-git-send-email-rahul.sharma@samsung.com>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-7-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1419145.DZQg0ZkHVU@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On Friday 06 of December 2013 21:26:30 Rahul Sharma wrote:
> Add support for pll2650xx in samsung pll file. This pll variant
> is close to pll36xx but uses CON2 registers instead of CON1.

If the ops are otherwise idential, why not reuse the ops for pll36xx
and use CON1 or CON2 register conditionally based on pll->type field?
(Just as it is already done for pll4600, 4650 and 4650c.)

Best regards,
Tomasz
