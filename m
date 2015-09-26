From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 17:05:32 +0200
Subject: [PATCH v3 23/26] ARM: pxa: magician: Remove definition of the
 STUART port
In-Reply-To: <55FB66DC.4090303@tul.cz> (Petr Cvek's message of "Fri, 18 Sep
 2015 03:20:28 +0200")
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FB66DC.4090303@tul.cz>
Message-ID: <87h9mhgr0j.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Magician STUART port is connected to the infraport and used by the FICP
> driver. The FICP driver uses its own definition.
>
> Required for correct initialization of the pxaficp_ir driver after
> planned dmaengine conversion.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
