From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:39:24 +0200
Subject: [PATCH v3 10/26] ARM: pxa: magician: Optimize Samsung LCD refresh
 to 50Hz
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA4857.5030904@tul.cz>
Message-ID: <87vbaxi6dl.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Change the default Samsung LCD refresh from an unrealistic 117Hz to 50Hz
> as no video applications on the HTC Magician can work that fast.
>
> The optimalization lowers the RAM latency at least by 3%.
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
