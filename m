From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 28 Jun 2012 10:46:11 +0200
Subject: [PATCH] ARM: i.MX SSI: Removed an unnecessary setting SSI_SCR_NET
 bit
In-Reply-To: <1340865557-4626-1-git-send-email-shc_work@mail.ru>
References: <1340865557-4626-1-git-send-email-shc_work@mail.ru>
Message-ID: <20460.6611.441889.115771@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alexander Shiyan writes:
> This patch removes unnecessary setting of SSI_SCR_NET bit in code
> of setup format for i.MX SSI. This bit is we are already setup at
                                         ^^^^^^^^^
parse error.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
