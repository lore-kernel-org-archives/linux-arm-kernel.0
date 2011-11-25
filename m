From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 25 Nov 2011 15:26:45 +0000 (GMT)
Subject: USB Serial Gadget regression on pxa27x-udc
Message-ID: <1322234805.41847.YahooMailClassic@web29003.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB serial gadget on pxa27x-udc seems to be broken in 3.1.0.

It was working OK on my hx4700 running 3.0.1. But with 3.1.0 (and at least 3.2.0-rc2 and 3.2.0-rc3) I now see the following warning:

pxa27x-udc pxa27x-udc: ep0:handle_ep0:should never get in WAIT_ACK_SET_CONF_INTERF state here!!!

I can still seemingly connect to the hx4700 from my linux host using cu(1) as before, but no characters get transferred in either direction.
