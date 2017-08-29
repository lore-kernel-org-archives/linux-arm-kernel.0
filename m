From: davem@davemloft.net (David Miller)
Date: Tue, 29 Aug 2017 10:56:51 -0700 (PDT)
Subject: [PATCH] net: stmmac: constify clk_div_table
In-Reply-To: <a54fe9764d287df370c16b0f0814d09d8fa24591.1503899422.git.arvind.yadav.cs@gmail.com>
References: <a54fe9764d287df370c16b0f0814d09d8fa24591.1503899422.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170829.105651.2053286906261018644.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Mon, 28 Aug 2017 11:22:20 +0530

> clk_div_table are not supposed to change at runtime.
> meson8b_dwmac structure is working with const clk_div_table.
> So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied.
