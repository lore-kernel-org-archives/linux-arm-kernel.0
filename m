From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 11:18:37 -0700
Subject: [PATCH v3 03/10] clk: qcom: Add CPU clock driver for msm8996
In-Reply-To: <024f01d3c1cb$304eaa60$90ebff20$@codeaurora.org>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-4-git-send-email-ilialin@codeaurora.org>
 <152148100496.242365.3846617702949655708@swboyd.mtv.corp.google.com>
 <024f01d3c1cb$304eaa60$90ebff20$@codeaurora.org>
Message-ID: <152303871765.143116.6979602150972963768@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting ilialin at codeaurora.org (2018-03-22 03:47:30)
> 
> I will have to change the clk_hw_unregister_fixed_rate() as well then, right? This will be an API change.

You won't need to unregister anything? devm will take care of it.
