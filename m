From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 23 Jan 2018 09:40:55 +0800
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <1516643421.25726.17.camel@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
 <20180122144729.GA27764@dragon>
 <CAK8P3a0Yq1WuUYih6WKbbjoGRwq-rCQ8OEpuyu0=-SOVV2MNLg@mail.gmail.com>
 <1516643421.25726.17.camel@pengutronix.de>
Message-ID: <20180123014054.GB27764@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 06:50:21PM +0100, Lucas Stach wrote:
> The nice thing about the split into Freescale/NXP is that it nicely
> separates the Layerscape and i.MX stuff, which are two quite different
> architectures.

With more and more IPs shared between Layerscape and i.MX, the boundary
of these two architectures becomes blurry.

> But that's just a nice coincidence and I'll happily
> rework the patches to whatever suits the maintainers most. Please make
> a judgement call.

Let's put them into 'freescale' folder.  Thanks.

Shawn
