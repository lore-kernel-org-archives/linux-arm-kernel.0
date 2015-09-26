From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 17:02:30 +0200
Subject: [PATCH v3 20/26] ARM: pxa: magician: Add support for MAX1587A
 Vcore regulator
In-Reply-To: <55FB6688.3010505@tul.cz> (Petr Cvek's message of "Fri, 18 Sep
 2015 03:19:04 +0200")
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FB6688.3010505@tul.cz>
Message-ID: <87pp15gr5l.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> HTC Magician contains a MAX1587A voltage regulator for a Vcore supply.
> The Vcore regulation is required for a CPU speed switching. This patch adds
> declaration for the max1586 driver.
>
> Notice:
>
> - MAX1587A version does not support the V6 (USIM) output.
> - A boost resistor was directly measured for a board_id 0x3a.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
