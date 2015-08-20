From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 20 Aug 2015 21:32:21 +0200
Subject: [PATCH v2 11/21] ARM: pxa: magician: Add MAX1586 Vcore regulator
 support
In-Reply-To: <55D259CC.6040307@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
 2015 00:01:48 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259CC.6040307@tul.cz>
Message-ID: <87pp2h69iy.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Add support for MAX1586 Vcore regulator.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
I'll leave that for a week and if no objections queue it.

I would have expected a better commit message : for example, from your patch I
deduce magician has a 1587 regulator, not a 1586 one : that deserves a small
mention in the commit message. Moreover, the Maxim has 2 outputs : one is
connected to VCC_Core of the SoC, what about the other output ?  Is it unknown,
or do you know but don't use it ?

Cheers.

--
Robert
