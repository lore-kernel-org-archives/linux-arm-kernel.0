From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 Aug 2015 18:25:32 +0200
Subject: [PATCH v2 17/21] ARM: pxa: magician: Remove (temporarily) pasic3
 LED support
In-Reply-To: <55D25A74.3030902@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
 2015 00:04:36 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25A74.3030902@tul.cz>
Message-ID: <87vbc747er.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Temporarily remove pasic3 LEDs definition as it is not used (yet).
I don't understand the split between this patch and patch 19/21. Is it for
bisectability, are they symetric (this one removes what the next adds) ?

As the patch 18/21 will probably go through Lee's tree, is there any value in
keeping them apart ?

Cheers.

--
Robert
