From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2016 11:42:47 +0200
Subject: [PATCH 1/2] smc91x: always use 8-bit access if necessary
In-Reply-To: <20160825223308.GJ1041@n2100.armlinux.org.uk>
References: <20160825144633.1850889-1-arnd@arndb.de>
 <20160825223308.GJ1041@n2100.armlinux.org.uk>
Message-ID: <2740439.XeNYfcEoZp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 25, 2016 11:33:08 PM CEST Russell King - ARM Linux wrote:
> 
> This is insufficient.  If you look at how SMC_REG works, you'll notice
> that it has side effects which can disrupt other accesses (it reads
> the bank register if debugging is enabled.)

Ok, got it.

	Arnd
