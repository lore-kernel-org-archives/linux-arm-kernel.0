From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 17:09:02 +0200
Subject: [PATCH v3 26/26] ARM: pxa: magician: Move platform_add_devices()
 to the end of magician_init()
In-Reply-To: <55FB671D.1090006@tul.cz> (Petr Cvek's message of "Fri, 18 Sep
 2015 03:21:33 +0200")
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FB671D.1090006@tul.cz>
Message-ID: <874mihgqup.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch moves platform_add_devices() (standard declaration of devices)
> outside of the platform specific device declarations. Moving to the end
> of the magician_init() clarifies the source code (standard and specific
> declaration are not mixed).
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Waiting for a week for Philipp's ack and queuing it after.

Cheers.

--
Robert
