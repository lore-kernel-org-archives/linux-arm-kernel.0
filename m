From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:41:59 +0200
Subject: [PATCH v3 12/26] ARM: pxa: magician: Rename charger cable
 detection EGPIOs
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA4887.9060404@tul.cz>
Message-ID: <87k2rdi6dj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch renames EGPIOs, which are used for the charging cable presence
> and type detection. Old names did not correspond with an observed
> functionality (on board_id 0x3a). The behavior is not:
>
> - AC charger
> - USB charger
> - Cable detection
>
> , but:
>
> - AC/USB type
> - Cable detection1
> - Cable detection2
>
> This patch fixes a possible typo in the bit offset for the cable detection
> EGPIO declaration, too.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
