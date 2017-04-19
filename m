From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 19 Apr 2017 21:14:05 +0200
Subject: [PATCH 3/4] mmc: pxamci: Disable DATA_TRAN_DONE interrupt sooner
In-Reply-To: <04139c1a-cee8-f64c-4b0e-2e3c472169a3@tul.cz> (Petr Cvek's
 message of "Wed, 19 Apr 2017 01:17:33 +0200")
References: <cover.1492492523.git.petr.cvek@tul.cz>
 <04139c1a-cee8-f64c-4b0e-2e3c472169a3@tul.cz>
Message-ID: <87k26g6whu.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Disable the DATA_TRAN_DONE interrupt as soon as possible in the handler.
Yeah, but why, please explain.
If that's only to "reduce" the race occurrence, then I'd rather have this patch
dropped. Otherwise if there is a compelling reason let's see ...

Cheers.

-- 
Robert
