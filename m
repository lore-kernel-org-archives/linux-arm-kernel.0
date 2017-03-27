From: dcb314@hotmail.com (David Binderman)
Date: Mon, 27 Mar 2017 10:47:11 +0000
Subject: drivers/clk/bcm/clk-iproc-pll.c:280]: (style) Redundant condition
Message-ID: <HE1PR0801MB186548205AD0A49B09F6A3149C330@HE1PR0801MB1865.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,


linux-4.11-rc4/drivers/clk/bcm/clk-iproc-pll.c:280]: (style) Redundant condition: If 'rate >= 2200000000', the comparison 'rate' is always true.

Source code is

    } else if (rate >= VCO_HIGH && rate && rate < VCO_HIGH_HIGH) {

Suggest new code

    } else if (rate >= VCO_HIGH  && rate < VCO_HIGH_HIGH) {

Regards

David Binderman
