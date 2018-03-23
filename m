From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 23 Mar 2018 10:11:02 -0700
Subject: [PATCH v11 1/2] dt-binding: clk: npcm750: Add binding for Nuvoton
 NPCM7XX Clock
In-Reply-To: <1521553249-6971-2-git-send-email-tali.perry1@gmail.com>
References: <1521553249-6971-1-git-send-email-tali.perry1@gmail.com>
 <1521553249-6971-2-git-send-email-tali.perry1@gmail.com>
Message-ID: <152182506241.178046.9923016351698583201@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting tali.perry1 at gmail.com (2018-03-20 06:40:48)
> From: Tali Perry <tali.perry1@gmail.com>
> 
> * Nuvoton NPCM7XX Clock Controller
> 
> Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
> generates and supplies clocks to all modules within the BMC.
> 
> ---
> 
> 10 ==> 11
> update documentation. "eth" replaced with "ethernet" in use case eaxample.
> 
> 2 ==> 10
> update documentation. add external clocks as inputs to clk driver.
> fix SPDX comment.
> 
> 1 ==> 2
> This patch includes fix request described here:
> https://patchwork.kernel.org/patch/10200033/
> (move fixed clocks to DT)
> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

But this part goes before the triple dash. I'll apply it and fix it up
on clk-next.
