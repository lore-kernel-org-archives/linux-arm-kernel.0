From: karl@micro-technic.com (Karl Olsen)
Date: Mon, 30 Nov 2009 14:48:36 +0100
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
References: <20091129234917.GB18841@game.jcrosoft.org><1259574486-13391-1-git-send-email-derkling@gmail.com>
	<1259574486-13391-2-git-send-email-derkling@gmail.com>
Message-ID: <E1B6D643836E44EEA8CC65C5C68E6966@KARL>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Original Message ----- 
From: "Patrick Bellasi" <derkling@gmail.com>
To: <linux-arm-kernel@lists.infradead.org>
Cc: "Patrick Bellasi" <derkling@gmail.com>; "Jean-Christophe
PLAGNIOL-VILLARD" <plagnioj@jcrosoft.com>; "Andrew Victor"
<linux@maxim.org.za>
Sent: Monday, November 30, 2009 10:48 AM
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11

> This patch update the at91_eth_data to handle the usage of PA10 and PA11
> for EMAC's EXT2 and EXT3 signals.
>
> The default configuration overlaps with TWI signals, using the new
> platform data configuration option "use_twi_pins" it is possible to use
> a different pin routing.

As everybody until now has used the TWI pins, wouldn't it be better to leave
them as the default, and introduce a "use_mcda_pins" option for PA10-11
instead?

Karl Olsen
