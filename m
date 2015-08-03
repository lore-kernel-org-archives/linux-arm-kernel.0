From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 03 Aug 2015 11:18:43 +0100
Subject: [PATCH 0/3] Move clk-sp810 to assigned clock parents
In-Reply-To: <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
References: <55BBB2FC.9030102@codeaurora.org>
 <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <55BF4003.3040708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 01/08/15 00:44, Stephen Boyd wrote:
> This patch set converts this code to use the assigned-clock-parents
> property instead of doing some interesting stuff in the .prepare
> op. I can route the dts patches through arm-soc but I'd like to take
> the clk patch through clk tree because it removes some usage of the
> struct clk based provider APIs that we're trying to get rid of. Also,
> this is completely untested, so testing would be appreciated.
> Can this be tested with qemu? I haven't tried but I was thinking
> that might be an option.
>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
>

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
(Tested the series on Juno R0 and Vexpress TC2 platform)

Regards,
Sudeep
