From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:40:49 +0200
Subject: [PATCH v3 11/26] ARM: pxa: magician: Optimize EGPIO initial values
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA4870.7040907@tul.cz>
Message-ID: <87pp15i6dk.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch optimizes initial values of the EGPIO chip driver.
>
> GSM and sound should be powered off during boot. A weak accumulator and
> a powered GSM sometimes cause a system reboot. A charging current should be
> as high as possible during boot.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
