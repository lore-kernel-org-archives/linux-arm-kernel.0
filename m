From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 21 Aug 2014 14:11:07 +0100
Subject: [PATCH 1/5] mmc: remove .owner field for drivers using
 module_platform_driver
In-Reply-To: <3815db00-4b32-4484-b97e-2144dc5abb45@BY2FFO11FD040.protection.gbl>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
 <1407860069-12706-2-git-send-email-peter.griffin@linaro.org>
 <3815db00-4b32-4484-b97e-2144dc5abb45@BY2FFO11FD040.protection.gbl>
Message-ID: <20140821131107.GA17487@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Mon, 18 Aug 2014, Michal Simek wrote:

> I have checked this for all xilinx drivers we have in the tree
> and I have sent similar patches.
> This problem is probably in all subsystems.

Yep

> With communication with Mark Brown. Don't you have
> cocinelle script for fixing this everywhere?

Nope. Never really looked at cocinelle until now, but it looks like
a useful tool for these sort of mass updates.

regards,

Peter.
