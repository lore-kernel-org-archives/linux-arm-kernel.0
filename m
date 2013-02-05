From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Feb 2013 20:09:27 +0100
Subject: [GIT PULL] ARM: mvebu fixes for v3.8-rc6 (round 2)
In-Reply-To: <20130205185758.GB21776@quad.lixom.net>
References: <1360013837.bfC5F0.15090@triton>
 <20130205140353.GT14746@titan.lakedaemon.net>
 <20130205185758.GB21776@quad.lixom.net>
Message-ID: <2785183.WbVPeMzV9Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013 10:57:58 Olof Johansson wrote:
> > 
> > While only one user reported the above problems (Simon Baatz), it was
> > caused by compiling v3.8-rc5 with the debian kernel config.  This config
> > builds almost everything it can as a module.
> 
> Is debian planning on shipping 3.8 on these platforms, or is it just one user
> that tried to build it for his own use?

I believe there is quite an active community around kirkwood running Debian,
since the combination is used on a lot of home NAS systems.

	Arnd
