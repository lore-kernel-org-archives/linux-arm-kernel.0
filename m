From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 19 Feb 2016 09:08:46 +0100
Subject: [PATCH 05/12] spi: imx: initialize usedma earlier
In-Reply-To: <1455867792-26389-6-git-send-email-s.hauer@pengutronix.de>
References: <1455867792-26389-1-git-send-email-s.hauer@pengutronix.de>
 <1455867792-26389-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160219090846.3004de9d@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 19 Feb 2016 08:43:05 +0100 Sascha Hauer wrote:
> So that the SoC specific config function can know if we will do
>
It's not quite obvious that this partial sentence is a continuation of
the subject header, even more since it starts with a capital letter...


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
