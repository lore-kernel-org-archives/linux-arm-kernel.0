From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 22 Jan 2015 09:34:23 +0000
Subject: [STLinux Kernel] [PATCH 1/1] i2c: i2c-st: Rename clock reference
 to something that exists
In-Reply-To: <1409234523-20240-1-git-send-email-lee.jones@linaro.org>
References: <1409234523-20240-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150122093423.GA23580@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 28 Aug 2014, Lee Jones wrote:

> CLK_S_ICN_REG_0 hasn't existed for a while now.  This was renamed
> over a few commits, then finally removed in commit 5aa02b9 (ARM:
> STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock).
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
