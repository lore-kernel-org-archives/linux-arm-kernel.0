From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 21 Aug 2015 00:33:41 +0200
Subject: [PATCH v2 11/21] ARM: pxa: magician: Add MAX1586 Vcore regulator
 support
In-Reply-To: <87pp2h69iy.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259CC.6040307@tul.cz>
 <87pp2h69iy.fsf@belgarion.home>
Message-ID: <55D655C5.40506@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 20.8.2015 v 21:32 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> Add support for MAX1586 Vcore regulator.
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> I'll leave that for a week and if no objections queue it.
> 
> I would have expected a better commit message : for example, from your patch I
> deduce magician has a 1587 regulator, not a 1586 one : that deserves a small
> mention in the commit message. Moreover, the Maxim has 2 outputs : one is
> connected to VCC_Core of the SoC, what about the other output ?  Is it unknown,
> or do you know but don't use it ?
> 
You mean V6 - Usim? MAX1587 does not have this pin implemented. I will note it in commit message.


> Cheers.
> 
> --
> Robert
> 
