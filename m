From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 16:56:37 +0200
Subject: [PATCH v3 16/26] ARM: pxa: magician: Fix support for Intel Strata
 NOR Flash
In-Reply-To: <55FB6608.1010501@tul.cz> (Petr Cvek's message of "Fri, 18 Sep
 2015 03:16:56 +0200")
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FB6608.1010501@tul.cz>
Message-ID: <8737y1i5zu.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Old definition for the physmap-flash driver is incomplete:
> - Use of an EGPIO without previous request
> - Missing the MTD partitions
>
> This patch fixes it. Read functionality was tested on the machine with
> board_id 0x3a. Writing was not tested.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
