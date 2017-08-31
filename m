From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 31 Aug 2017 10:59:01 -0700
Subject: [GIT PULL] Allwinner clock changes for 4.14, take 3
In-Reply-To: <20170824083620.b5cq4qtyr3cqtpjx@flea.lan>
References: <20170824083620.b5cq4qtyr3cqtpjx@flea.lan>
Message-ID: <20170831175901.GF21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Maxime Ripard wrote:
> Hi,
> 
> Here is a quite late PR, but this also something we've been waiting
> for for quite some time already.
> 
> These patches convert our last users of the old clock framework to the
> new one. We still have some marginal users of the old clock drivers,
> but they shouldn't prevent the fix for the orphans clocks we hold back
> to work.
> 

Great. Thanks. Pulled into clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
