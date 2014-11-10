From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 10 Nov 2014 11:22:14 +0100
Subject: ARM: sti: SOC_STIH407 and STIH407_RESET?
Message-ID: <1415614934.4862.22.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Your commit c27321141915 ("ARM: sti: Add STiH407 Kconfig entry to select
STIH407_RESET") was included in today's linux-next (ie, next-20141110).
It adds a Kconfig entry for SOC_STIH407. That entry selects
STIH407_RESET.

There's no Kconfig symbol STIH407_RESET. And there's nothing in
next-20141110 that cares about SOC_STIH407. So this entry is currently a
nop.

I assume that there are one or more patches queued that make this entry
do something. Is that correct?


Paul Bolle
