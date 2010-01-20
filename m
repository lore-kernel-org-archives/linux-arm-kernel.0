From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jan 2010 11:54:14 +0000
Subject: [PATCH] mx3fb: some debug and initialisation fixes.
In-Reply-To: <1263985973.3083.28.camel@realization>
References: <1261152262.3356.69.camel@climbing-alby>
	<Pine.LNX.4.64.0912201744490.14323@axis700.grange>
	<1263985973.3083.28.camel@realization>
Message-ID: <20100120115413.GA7725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 12:12:53PM +0100, Alberto Panizzo wrote:

> Thanks Guennadi for Acking.
> Forgive me, but I not understand well the correct path for pulling this 
> patch to linus tree.
> I thought that Sascha was the right maintainer so I cc-ed him. But
> I am wrong right?

> Please can you point me to the right mailing list or maintainer?

scripts/get_maintainer.pl should be able to tell you - the general
framebuffer subsystem path is via akpm at the moment.
