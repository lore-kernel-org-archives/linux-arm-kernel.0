From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 13 Dec 2010 08:23:16 +0100
Subject: [PATCH 5/9] Add i.MX5 framebuffer driver
In-Reply-To: <AANLkTikZowDCK4JPiCyEou1ekRuYA1qGnKrBPT5dXB+8@mail.gmail.com>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-6-git-send-email-s.hauer@pengutronix.de>
	<AANLkTikZowDCK4JPiCyEou1ekRuYA1qGnKrBPT5dXB+8@mail.gmail.com>
Message-ID: <19717.51684.567190.925646@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Liu Ying writes:
> 6) I prefer to find the video mode in modedb first, and if we cannot
> find the video mode in common video mode data base, we can find a
> video mode in custom video mode data base which is defined in platform
> data. In this way, we don't need to export common modefb.
> 
IMO platform specific video modes should take precedence over generic
ones, so the platform data should be evaluated first.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
