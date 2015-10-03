From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 14:30:09 +0200
Subject: [PATCH v4 07/26] ARM: pxa: magician: Fix HTC Magician pin mux
 definitions
In-Reply-To: <5609ADF5.9070003@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609ADF5.9070003@tul.cz>
Message-ID: <1443875409.4186.20.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:15 +0200 schrieb Petr Cvek:
> This patch fixes a pin mux for the HTC Magician machine. Wrong and
> missing
> definitions caused a bad LCD operation and an unavailability of
> several
> peripherals.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

NAK on this one. Until this patch I can boot my o2 Xda mini with
Toppoly display and see the framebuffer kernel console output. Can we
split the LCD changes from the rest, I assume those are what breaks my
display.

best regards
Philipp
