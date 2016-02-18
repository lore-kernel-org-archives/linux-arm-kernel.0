From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu, 18 Feb 2016 11:07:40 +0100
Subject: Using i.MX6 quad's IPU#1/DI#1 to drive parallel port #1 failed
In-Reply-To: <20160217155814.7f7132aa@ipc1.ka-ro>
References: <201602171210.14545.jbe@pengutronix.de>
 <201602171523.55881.jbe@pengutronix.de> <20160217155814.7f7132aa@ipc1.ka-ro>
Message-ID: <201602181107.41129.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Wednesday 17 February 2016 15:58:14 Lothar Wa?mann wrote:
> > thank you for your answer. Can you also send me your "pinctrl_disp1"
> > definition, please?
>
> 		pinctrl_disp1: disp1grp {
> 			fsl,pins = <
> 				MX6QDL_PAD_EIM_A16__IPU1_DI1_DISP_CLK	0x10
> 				MX6QDL_PAD_EIM_DA10__IPU1_DI1_PIN15	0x10

The "PIN15" was the key. With your definition it now works here as well.

Thank you for your help.

Regards,
Juergen
