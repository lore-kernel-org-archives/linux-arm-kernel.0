From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 17 Feb 2016 15:58:14 +0100
Subject: Using i.MX6 quad's IPU#1/DI#1 to drive parallel port #1 failed
In-Reply-To: <201602171523.55881.jbe@pengutronix.de>
References: <201602171210.14545.jbe@pengutronix.de>
 <20160217140902.5e24c074@ipc1.ka-ro>
 <201602171523.55881.jbe@pengutronix.de>
Message-ID: <20160217155814.7f7132aa@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 17 Feb 2016 15:23:55 +0100 Juergen Borleis wrote:
> Hi Lothar,
> 
> thank you for your answer. Can you also send me your "pinctrl_disp1" 
> definition, please?
> 
		pinctrl_disp1: disp1grp {
			fsl,pins = <
				MX6QDL_PAD_EIM_A16__IPU1_DI1_DISP_CLK	0x10
				MX6QDL_PAD_EIM_DA10__IPU1_DI1_PIN15	0x10
				MX6QDL_PAD_EIM_DA11__IPU1_DI1_PIN02	0x10
				MX6QDL_PAD_EIM_DA12__IPU1_DI1_PIN03	0x10
				MX6QDL_PAD_EIM_DA9__IPU1_DISP1_DATA00	0x10
				MX6QDL_PAD_EIM_DA8__IPU1_DISP1_DATA01	0x10
				MX6QDL_PAD_EIM_DA7__IPU1_DISP1_DATA02	0x10
				MX6QDL_PAD_EIM_DA6__IPU1_DISP1_DATA03	0x10
				MX6QDL_PAD_EIM_DA5__IPU1_DISP1_DATA04	0x10
				MX6QDL_PAD_EIM_DA4__IPU1_DISP1_DATA05	0x10
				MX6QDL_PAD_EIM_DA3__IPU1_DISP1_DATA06	0x10
				MX6QDL_PAD_EIM_DA2__IPU1_DISP1_DATA07	0x10
				MX6QDL_PAD_EIM_DA1__IPU1_DISP1_DATA08	0x10
				MX6QDL_PAD_EIM_DA0__IPU1_DISP1_DATA09	0x10
				MX6QDL_PAD_EIM_EB1__IPU1_DISP1_DATA10	0x10
				MX6QDL_PAD_EIM_EB0__IPU1_DISP1_DATA11	0x10
				MX6QDL_PAD_EIM_A17__IPU1_DISP1_DATA12	0x10
				MX6QDL_PAD_EIM_A18__IPU1_DISP1_DATA13	0x10
				MX6QDL_PAD_EIM_A19__IPU1_DISP1_DATA14	0x10
				MX6QDL_PAD_EIM_A20__IPU1_DISP1_DATA15	0x10
				MX6QDL_PAD_EIM_A21__IPU1_DISP1_DATA16	0x10
				MX6QDL_PAD_EIM_A22__IPU1_DISP1_DATA17	0x10
				MX6QDL_PAD_EIM_A23__IPU1_DISP1_DATA18	0x10
				MX6QDL_PAD_EIM_A24__IPU1_DISP1_DATA19	0x10
				MX6QDL_PAD_EIM_D31__IPU1_DISP1_DATA20	0x10
				MX6QDL_PAD_EIM_D30__IPU1_DISP1_DATA21	0x10
				MX6QDL_PAD_EIM_D26__IPU1_DISP1_DATA22	0x10
				MX6QDL_PAD_EIM_D27__IPU1_DISP1_DATA23	0x10
			>;
		};


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
