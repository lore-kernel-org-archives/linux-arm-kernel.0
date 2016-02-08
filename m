From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 8 Feb 2016 14:26:37 -0800
Subject: [PATCH 0/2] CREG clk driver for NXP LPC18xx family
In-Reply-To: <1436651307-24098-1-git-send-email-manabian@gmail.com>
References: <1436651307-24098-1-git-send-email-manabian@gmail.com>
Message-ID: <20160208222637.GV4848@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11, Joachim Eastwood wrote:
> This patch set adds a clk driver for the low power clocks found in
> the CREG block on lpc18xx. CREG is a collection of miscellaneous
> configuration registers that can be accessed through a syscon
> regmap interface. The clk driver makes it possible to setup and
> enabled these two clocks.
> 
> This need to support peripherals like the internal RTC on the
> lpc18xx platform.
> 

I know this is many months old, but is this driver still
required? I can apply it to clk-next if so.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
