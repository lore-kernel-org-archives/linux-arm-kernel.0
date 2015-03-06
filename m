From: dwalker@fifo99.com (dwalker at fifo99.com)
Date: Fri, 6 Mar 2015 23:07:16 +0000
Subject: APM get soc mhz rate?
Message-ID: <20150306230716.GA7172@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was wondering if xgene has a generic way of getting the soc clock rate ? I found a function using
the pcppll and a divisor for the pmd, but I wanted to use something more generic like thru the clk
framework. Have you added anything , or have anything planning, which would allow that?

Or for anyone else might be reading this, is there a generic way to get a soc clock rate?

Daniel
