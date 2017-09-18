From: dcb314@hotmail.com (David Binderman)
Date: Mon, 18 Sep 2017 16:37:27 +0000
Subject: linux-4.14-rc1/drivers/clk/clk-stm32h7.c: 2 * possible typo ?
Message-ID: <HE1PR0802MB2331E50765AE7D68D32A85759C630@HE1PR0802MB2331.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

1.

linux-4.14-rc1/drivers/clk/clk-stm32h7.c:387]: (style) Same expression on both sides of '&&'.

Source code is

    if (gcfg->mux && gcfg->mux) {

2.

[linux-4.14-rc1/drivers/clk/clk-stm32h7.c:413]: (style) Same expression on both sides of '&&'.

Duplicate.

Regards

David Binderman
