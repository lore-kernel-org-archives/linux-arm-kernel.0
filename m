From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 20 Aug 2015 21:58:25 +0200
Subject: [PATCH v2 15/21] ARM: pxa: magician: Fix PWM backlight regulator
In-Reply-To: <55D25A4A.4070409@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
 2015 00:03:54 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25A4A.4070409@tul.cz>
Message-ID: <87d1yh68bi.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Fix PWM backlight regulator. It is requested from pwm_backlight_probe().
Even if I know why you have to fix it, somebody else reading your commit message
should understand why this fix is need. You need to explain why it is needed,
ie. what happens without it, and therefore what justifies this patch.

Cheers.

--
Robert

PS: For inspiration, look at Thierry's commit 902e6a0c7eba.
