From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 13:37:56 -0700
Subject: [PATCH] clk: stm32mp1: Fix a memory leak in
 'clk_stm32_register_gate_ops()'
In-Reply-To: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
References: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
Message-ID: <152641667642.237094.1285725983406005947@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Christophe JAILLET (2018-05-13 04:17:04)
> We allocate some memory which is neither used, nor referenced by anything.
> So axe it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
