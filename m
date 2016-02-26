From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Feb 2016 16:07:48 -0800
Subject: [PATCH] clk: bcm2835: added missing clock register definitions
In-Reply-To: <1450815189-3342-1-git-send-email-kernel@martin.sperl.org>
References: <1450815189-3342-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160226000748.GP28849@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Added missing CTRL and DIV clock register definitions for:
> PCM, SLIM, TCNT, TEC, TD0, TD1
> 
> Register information taken from:
> https://rawgit.com/msperl/rpi-registers/master/rpi-registers.html#CM
> which extracted the information from the header files shared by
> Broadcom/rpi foundation in this file:
> http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
