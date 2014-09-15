From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 15 Sep 2014 23:15:05 +0100
Subject: [PATCH] arm: Remove redundant config value DEBUG_UART_NETX
In-Reply-To: <1410818986-13273-1-git-send-email-daniel.thompson@linaro.org>
References: <1410818986-13273-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <541764E9.5030308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/14 23:09, Daniel Thompson wrote:
> Commit 880fa9b6fd73 ("ARM: 8144/1: netx: Migrate DEBUG_LL macros to
> shared directory") spuriously introduces an unused config variable,
> DEBUG_UART_NETX. Let's remove it.

Not sure if this is better shared as a new patch (as below) or respun
from the original (as 8144/2)?
