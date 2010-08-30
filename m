From: wolfgang.mues@auerswald.de (=?ISO-8859-1?Q?Wolfgang_M=FCes?=)
Date: Mon, 30 Aug 2010 08:51:37 +0200
Subject: [PATCH 1/7] mmc: at91_mci: fix pointer errors
In-Reply-To: <20100827193457.GC23079@void.printf.net>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
	<20100827193303.GB23079@void.printf.net>
	<20100827193457.GC23079@void.printf.net>
Message-ID: <4C7B54F9.6090200@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 27.08.2010 21:34, schrieb Chris Ball:
> On Fri, Aug 27, 2010 at 08:33:03PM +0100, Chris Ball wrote:
>> Looks like only the first half of this patch was applied?  The
>> kunmap_atomic() line is still present as before in Linus' tree.

It was argued that the kunmap_atomic() will truncate the pointer to the 
start of the page anyway, so the subtraction is not needed.

best regards

i. A. Wolfgang Muees

Hardware-Entwicklung
Leiter Pruefen & Layout
-- 
Auerswald Gesellschaft fuer Datensysteme mbH

Phone: +49 5306-9219-562
Fax:   +49 5306-9200-94
--------------------------------------------------------------
Auerswald Gesellschaft fuer Datensysteme mbH,
Vor den Grashoefen 1, 38162 Cremlingen

Registriert beim AG Braunschweig HRB 7499
Gesch?ftsf?hrer: Dipl-Ing. Gerhard Auerswald
