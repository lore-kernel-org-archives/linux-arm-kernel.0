From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:37:37 +0200
Subject: [PATCH v3 09/26] ARM: pxa: magician: Optimize powerup delays for
 Samsung LCD
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA483F.1040202@tul.cz>
Message-ID: <871tdljky2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Delays for the Samsung LCD are greater than needed. These values were
> extracted from a datasheet.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after. An ack on this one
would be warmly welcome Philipp, as I have no way to judge if these timings fit
the board you're using as well.

Cheers.

--
Robert
