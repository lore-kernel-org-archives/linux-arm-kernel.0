From: s.hauer@pengutronix.de (Sascha Hauer [s.hauer@pengutronix.de] (s.hauer@pengutronix.de))
Date: Wed, 14 Mar 2012 10:50:50 +0100
Subject: [PATCH] iomux-mx25.h slew rate adjusted for LCD __LD pins
In-Reply-To: <3F263ABB4EDE344D974E1983B56807739E868EAB@EX-DAG01.eckelmann.group>
References: <3F263ABB4EDE344D974E1983B56807739E868EAB@EX-DAG01.eckelmann.group>
Message-ID: <20120314095050.GP26642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 11:35:22AM +0000, Mehnert, Torsten wrote:
> From: Mehnert <tmehnert@eckelmann.de>
> Date: Mon, 13 Mar 2012 12:13:51 +0100
> Subject: [PATCH] iomux-mx25.h slew rate adjusted for LCD __LD pins
> 
> For some reason (sadly i don't identifying the patch right now)
> two LCD data lines configured PAD_CTL_SRE_SLOW (wrong slew rate)
> since Kernel 3.1. MX25_PAD_GPIO_E__LD16 and MX25_PAD_GPIO_F__LD17
> This results in an fauly behaviour and strange color effects.
> 
> To ensure that all LCD data pins configured with the proper slew rate,
> this patch changes to IOMUX define of all LCD __LDxx pins to PAD_CTL_SRE_FAST.
> 
> This problem may affect other mx25 platforms like mx25pdk. Sadly i can't test
> it. Of course this problem shouldn't occur when you done your LCD muxing 
> correctly in the bootloader.

Your patch lacks a signed-off-by Tag. Please remember adding it next
time. For now it should be enough to answer your original mail with
a

Signed-off-by: Torsten Mehnert <T.Mehnert@eckelmann.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
