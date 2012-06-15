From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 15 Jun 2012 15:01:59 +0200
Subject: Converting kirkwood-goflexnet to DTS (Josh Coombs)
Message-ID: <20120615130159.GA8061@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh

Looking at the warnings, it looks like you have too much in your .dti
file. For -rc2, only serial, rtc, and NAND are supported.

So only declare DT properties for these and nothing else.

   Andrew
