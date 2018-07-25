From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 24 Jul 2018 23:21:03 -0700
Subject: [PATCH v1 01/04] clk: actions: Add Actions Semi S500 SoC clock
 support
In-Reply-To: <CADHB5bAns1PmTvq=fG8Rc2S6orEh7wf5XYAGQONTKMsoYv-UTg@mail.gmail.com>
References: <CADHB5bAns1PmTvq=fG8Rc2S6orEh7wf5XYAGQONTKMsoYv-UTg@mail.gmail.com>
Message-ID: <153249966379.48062.8866967540355341765@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Edgar Bernardi Righi (2018-07-18 08:32:34)
> Add Actions Semi S500 SoC clock support.
> Basic clock support for S500 SoC was implemented using the Actions
> Semi Owl clock driver.
> Tested on a Lemaker Guitar board.
> 
> This patch depends on patch "[PATCH v6 1/5] clk: actions: Add missing
> REGMAP_MMIO dependency" by Saravanan Sekar.
> This patch depends on patch "[PATCH] clk: actions: Add custom delay
> option to Actions Semi OWL pll clock driver" by Edgar Bernardi Righi.

The depends list can be left out of the commit text and go below a
triple dash '---' after the sign-off chain.

> 
> File(s) created: "/drivers/clk/actions/owl-s500.c"
> File(s) updated: "/drivers/clk/actions/Makefile", "/drivers/clk/actions/Kconfig"

Please remove these "Files created" messages from your patches.
Preferably use git to format your patches before sending too, but using
diff is OK too I guess.

> 
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> 
> diff -uprN -X vanilla/Documentation/dontdiff
> vanilla/drivers/clk/actions/Kconfig linux/drivers/clk/actions/Kconfig
