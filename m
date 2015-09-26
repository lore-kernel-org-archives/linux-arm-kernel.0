From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:51:47 +0200
Subject: [PATCH v3 15/26] ARM: pxa: magician: Fix redundant GPIO request
 for pxaficp_ir
In-Reply-To: <55FA48CA.6000807@tul.cz> (Petr Cvek's message of "Thu, 17 Sep
 2015 06:59:54 +0200")
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA48CA.6000807@tul.cz>
Message-ID: <87a8s9i67w.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> The pxaficp_ir driver requests a power GPIO for the transceiver internally,
> so a global GPIO allocation in magician_init() is redundant.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
