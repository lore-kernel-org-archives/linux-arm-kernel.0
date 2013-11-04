From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 4 Nov 2013 15:47:08 +0100
Subject: [PATCHv9][ 4/6] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <20131104143140.GD15098@pengutronix.de>
References: <1383210928-18906-1-git-send-email-denis@eukrea.com>
 <1383210928-18906-4-git-send-email-denis@eukrea.com>
 <20131104143140.GD15098@pengutronix.de>
Message-ID: <20131104154708.6f288c39@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Markus Pargmann wrote:
> On Thu, Oct 31, 2013 at 10:15:26AM +0100, Denis Carikli wrote:
[...]
> > +#define MX25_PAD_CTL_GRP_DVS_SDHC1		0x000 0x458 0x000 0x00 0x000
> > +#define MX25_PAD_CTL_GRP_DVS_LCD		0x000 0x45c 0x000 0x00 0x000
> 
> These pinfunctions do not define a pinmux function for a pin. Instead
> they are used to configure the pin characteristics for a whole group of
> pins. I am not sure if they should be defined as "pin functions" for the
> iomux driver.
> 
Please trim the quoted text appropriately when answering.
It will take you less than 10 seconds to do so, but it will save
hundreds of readers of your mails those seconds when trying to find
your answer in the mail.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
