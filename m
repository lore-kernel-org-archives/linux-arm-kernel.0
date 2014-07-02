From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 02 Jul 2014 10:01:03 +0200
Subject: ASoC: samsung: MACH_SMDKC100
Message-ID: <1404288063.12021.13.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

Your commit 52ad6582ceb2 ("ARM: S5PC100: no more support S5PC100 SoC"
landed in next-20140702. It removed the Kconfig symbol MACH_SMDKC100
(and a lot of other stuff).

Is the trivial patch to also remove the last two references to
MACH_SMDKC100 from sound/soc/samsung/Kconfig/ queued somewhere? I don't
think it was part of the series that included the above commit.


Paul Bolle
