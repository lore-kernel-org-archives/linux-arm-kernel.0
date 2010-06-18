From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jun 2010 19:17:07 +0100
Subject: [PATCH 1/2] ARM: Factor out secondary CPU bootup code from
	RealView platforms
In-Reply-To: <20100618181451.GA17455@oksana.dev.rtsoft.ru>
References: <20100618181451.GA17455@oksana.dev.rtsoft.ru>
Message-ID: <20100618181707.GA21578@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 10:14:51PM +0400, Anton Vorontsov wrote:
> For CNS3xxx we want to reuse the original ARM approach of booting
> secondary CPUs. This patch turns RealView's code into "SCU library",
> so that now platform code can call the generic routines.

Please use vexpress as the basis for taking code from, not realview.
