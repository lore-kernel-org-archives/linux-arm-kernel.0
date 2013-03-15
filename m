From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 13:41:14 +0000
Subject: [PATCH] isdn: hisax: netjet requires VIRT_TO_BUS
In-Reply-To: <20130315.083344.2224038988420448687.davem@davemloft.net>
References: <201303151015.00746.arnd@arndb.de>
 <201303151229.52997.arnd@arndb.de>
 <20130315.083344.2224038988420448687.davem@davemloft.net>
Message-ID: <201303151341.14311.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, David Miller wrote:
> The first usage seems reason, but the temtation is going to be quite
> strong to misuse to block out drivers when there is "no value" in
> spending time necessary to simply make them endian clean instead.

Right. I'll let someone else start that discussion then if they
really want to see that patch.

	Arnd
