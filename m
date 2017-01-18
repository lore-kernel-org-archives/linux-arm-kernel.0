From: davem@davemloft.net (David Miller)
Date: Wed, 18 Jan 2017 16:50:50 -0500 (EST)
Subject: [PATCH net-next v4 00/10] net: dsa: Support for pdata in dsa2
In-Reply-To: <20170117232152.1661-1-f.fainelli@gmail.com>
References: <20170117232152.1661-1-f.fainelli@gmail.com>
Message-ID: <20170118.165050.2165692521961713529.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 17 Jan 2017 15:21:42 -0800

> This is not exactly new, and was sent before, although back then, I did not
> have an user of the pre-declared MDIO board information, but now we do. Note
> that I have additional changes queued up to have b53 register platform data for
> MIPS bcm47xx and bcm63xx.
 ...

We're waiting for Greg's further review and Vivien's changes which I just
applied are going to create some conflicts, so I am presuming that you will
respin a v5 anyways.
