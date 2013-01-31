From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Jan 2013 17:21:19 +0100
Subject: BogoMIPS change in 3.6+
In-Reply-To: <510A988F.6030508@gmail.com>
References: <510A988F.6030508@gmail.com>
Message-ID: <1397779.tl4QmIB7p2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013 10:15:11 Rob Herring wrote:
> The BogoMIPS value has changed on highbank since the commit below in
> 3.6. It is now half the value it used to be. Does that matter other than
> perception (I've checked that I'm not running at half the freq)?

I think the only danger is that your customers might think they
are running at half the clock rate. Nothing in the kernel should
be using the BogoMIPS value.

	Arnd
