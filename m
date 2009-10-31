From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Oct 2009 17:39:32 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091031013427.GL14091@buzzloop.caiaq.de> (Daniel Mack's message
	of "Sat\, 31 Oct 2009 02\:34\:27 +0100")
References: <20091031013427.GL14091@buzzloop.caiaq.de>
Message-ID: <87r5sjwm9n.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@caiaq.de> writes:

> Does anyone use that successfully? Any idea for possible regressions?
The issue seems confirmed. My mioa701 phone doesn't resume either, with
2.6.32-rc5 kernel.

I have no console available (except pxafb, but that's much later in the resume
sequence), so I won't be of much help, sorry.

Cheers.

--
Robert
