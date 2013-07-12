From: b32955@freescale.com (Huang Shijie)
Date: Fri, 12 Jul 2013 16:50:58 +0800
Subject: [PATCH rebased 2/2] ARM: dts: imx6qdl-sabreauto: add a DT node
 for uart3
In-Reply-To: <20130712084025.GH25501@S2101-09.ap.freescale.net>
References: <1373615772-30665-1-git-send-email-b32955@freescale.com>
 <1373615772-30665-2-git-send-email-b32955@freescale.com>
 <20130712084025.GH25501@S2101-09.ap.freescale.net>
Message-ID: <51DFC372.2020309@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?12? 16:40, Shawn Guo ??:
>> >  +&uart3 {
>> >  +	pinctrl-names = "default";
>> >  +	pinctrl-0 =<&pinctrl_uart3_1>;
>> >  +	fsl,uart-has-rtscts;
>> >  +	dma-names = "rx", "tx";
>> >  +	dmas =<&sdma 29 4 0>,<&sdma 30 4 0>;
> These two properties should be added in imx6qdl.dtsi
the uart3 may does _not_ have the RTS/CTS pins except in the 
imx6q{dl}-sabreauto boards.

Is it proper to add the dma property in the imx6qdl.dtsi?


thanks
Huang Shijie
