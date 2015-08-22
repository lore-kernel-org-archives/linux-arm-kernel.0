From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 Aug 2015 18:27:30 +0200
Subject: [PATCH v2 21/21] ARM: pxa: magician: Move platform_add_devices()
 to the end of magician_init()
In-Reply-To: <55D25B07.1080703@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
 2015 00:07:03 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25B07.1080703@tul.cz>
Message-ID: <87r3mv47bh.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Move platform_add_devices() to the end of magician_init() for better
> clarity of code.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
With Philipp's ack.

-- 
Robert
