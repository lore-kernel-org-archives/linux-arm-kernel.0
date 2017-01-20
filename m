From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jan 2017 18:43:21 +0100
Subject: [PATCH v5 0/2] Add support for the ethernet switch on the
 ESPRESSObin
In-Reply-To: <87a8al64mp.fsf@free-electrons.com>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
 <20170119220607.GA25907@lunn.ch>
 <87a8al64mp.fsf@free-electrons.com>
Message-ID: <20170120174321.GF25907@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What I wanted to do was to test 6390 and 6352 temperature related
> functions and to see if one of them worked. That's how I realized it was
> not possible to do it with dsa2.

Hi Gregory

Probably the best thing to do is wait until the temperature code moves
into the PHY driver. It then becomes easier to test. It probably is
the same as the 6352, or like the 6390 which i've so far failed to get
working, despite the registers being the same as the 6352.

     Andrew
