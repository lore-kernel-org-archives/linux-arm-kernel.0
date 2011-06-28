From: davem@davemloft.net (David Miller)
Date: Mon, 27 Jun 2011 18:38:44 -0700 (PDT)
Subject: [PATCH v2] NET: AX88796: Tighten up Kconfig dependencies
In-Reply-To: <BANLkTikDxsOJKpiJs0NpMXbjVOFMHL7RZw@mail.gmail.com>
References: <20110627111259.GA13620@linux-mips.org>
	<BANLkTikDxsOJKpiJs0NpMXbjVOFMHL7RZw@mail.gmail.com>
Message-ID: <20110627.183844.146129637361136342.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jun 2011 09:40:56 +0900

> As for SH and SH-Mobile ARM, unless explicitly requested we usually
> don't restrict our platform drivers. Allowing them to build on any
> system helps to catch compile errors.

I totally agree with Magnus, drivers should build on as many systems
as possible.  Even on those for which the hardware never appears.

Ralf, unless these drivers have unfixable build errors on MIPS I
do not want to add the new restrictions.
