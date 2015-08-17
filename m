From: petr.cvek@tul.cz (Petr Cvek)
Date: Tue, 18 Aug 2015 00:14:46 +0200
Subject: [PATCH v2 19/21] leds: leds-pasic3: Add support for PASIC3 LED
 controller
In-Reply-To: <55D25ADC.10703@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25ADC.10703@tul.cz>
Message-ID: <55D25CD6.6040404@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 18.8.2015 v 00:06 Petr Cvek napsal(a):
> Add support for LEDs inside the PASIC3 chip.

BTW During research I have found there was driver in 

	https://github.com/hackndev/linux-hnd 

but it did not make up to vanilla, so I wrote mine from scratch (actually I
have tested the PASIC3 registers mostly by trial and error - and found some
for case open reset).
