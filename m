From: davem@davemloft.net (David Miller)
Date: Fri, 20 Jan 2017 14:17:05 -0500 (EST)
Subject: [PATCH v5 0/2] Add support for the ethernet switch on the
 ESPRESSObin
In-Reply-To: <20170119214934.27442-1-gregory.clement@free-electrons.com>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
Message-ID: <20170120.141705.1390880809796992457.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Thu, 19 Jan 2017 22:49:32 +0100

> I created a new family for this switch and filled the ops structure
> by selecting which seems the more appropriate functions. I rebased
> the series on net-next/master which allowed me to benefit to the
> eeprom functions introduced for the 6390.

It looks like there will be at least one more respin of this series,
specifically to remove the new family as Vivien seems to object to
this.
