From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 16 Mar 2018 15:44:31 -0700
Subject: [PATCH 1/1] Documentation: clk: enable lock is not held for
 clk_is_enabled API
In-Reply-To: <1516369035-24740-1-git-send-email-aisheng.dong@nxp.com>
References: <1516369035-24740-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <152124027193.242365.12812965857871498513@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dong Aisheng (2018-01-19 05:37:15)
> The core does not need to hold enable lock for clk_is_enabled API.
> Update the doc to reflect it.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next
