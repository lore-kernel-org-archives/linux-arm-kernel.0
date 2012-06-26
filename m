From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 26 Jun 2012 11:11:35 +0200
Subject: [PATCH 3/3] net: fec: add phy-reset-interval for device tree probe
In-Reply-To: <1340700308-8315-4-git-send-email-shawn.guo@linaro.org>
References: <1340700308-8315-1-git-send-email-shawn.guo@linaro.org>
 <1340700308-8315-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20457.31943.332545.171232@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> Different boards may require different phy reset interval time.  Add
> property phy-reset-interval for device tree probe, so that the boards
> that need a longer interval time can specify it in their device tree.
>
'phy-reset-duration' would be a more appropriate name.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
