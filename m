From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Aug 2010 14:19:12 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
Message-ID: <20100810121912.GG27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

Sorry, last time I sent only up to 09/12, so the patches I explicitely
mentioned to solve the things from your previous series were missing.
I just sent them. My versions of the patches differ slightly. For this
patch I decided to initialize every bit in NFC_V1_V2_CONFIG1 from
scratch so that we do not depend on any reset or bootloader values.
I think this is cleaner so I propose that we use my version of the
patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
