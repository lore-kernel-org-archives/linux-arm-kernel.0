From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Aug 2013 09:48:14 -0600
Subject: [PATCH 1/9] clk: bcm2835: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <520903BE.7000705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 03:13 AM, Sachin Kamat wrote:
> __initconst should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

I assume Mike will take this through the clk tree.
