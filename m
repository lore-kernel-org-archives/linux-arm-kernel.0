From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 28 Sep 2009 12:28:33 +0200
Subject: [PATCH 1/2] n2100: support assigning XINT1 to UART
In-Reply-To: <4AC05D78.20007@nokia.com>
References: <19134.28977.5491.323804@pilspetsen.it.uu.se>
	<4AC05D78.20007@nokia.com>
Message-ID: <19136.36817.434763.631577@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen writes:
 > Hello,
 > 
 > Mikael Pettersson wrote:
 > > +config N2100_XINT1_UART
 > > +	bool "Support assigning Thecus n2100 XINT1 to UART"
 > > +	depends on MACH_N2100 && NO_HZ
 > 
 > This shouldn't depend on NO_HZ. Some people may want to use it
 > just to get (much) faster serial console.

Agreed, this configuration has benefits also for NO_HZ.
I'll drop that dependency.
