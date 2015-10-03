From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 14:35:05 +0200
Subject: [PATCH v4 11/26] ARM: pxa: magician: Optimize EGPIO initial values
In-Reply-To: <5609B1E9.4020508@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B1E9.4020508@tul.cz>
Message-ID: <1443875705.4186.24.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:32 +0200 schrieb Petr Cvek:
> This patch optimizes initial values of the EGPIO chip driver.
> 
> GSM and sound should be powered off during boot. A weak accumulator
> and
> a powered GSM sometimes cause a system reboot. A charging current
> should be
> as high as possible during boot.

Wouldn't that violate USB spec if we boot the magician while plugged
into an unpowered USB host?

regards
Philipp
