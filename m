From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:57:20 +0200
Subject: [PATCH v3 17/26] ARM: pxa: magician: Fix wrongly enabled USB host
 ports
In-Reply-To: <55FB6621.5080607@tul.cz> (Petr Cvek's message of "Fri, 18 Sep
 2015 03:17:21 +0200")
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FB6621.5080607@tul.cz>
Message-ID: <87y4ftgre7.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> USB host ports on the HTC Magician are wrongly enabled. Port 1 is for
> bluetooth and port 2 is for OTG (mux in the charger connector).
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
