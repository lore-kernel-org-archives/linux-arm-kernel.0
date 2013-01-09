From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Jan 2013 10:51:12 +0900
Subject: [PATCH 2/2] ARM: shmobile: add a reference DT implementation for
 mackerel
In-Reply-To: <Pine.LNX.4.64.1212311214370.24596@axis700.grange>
References: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
 <Pine.LNX.4.64.1212311214370.24596@axis700.grange>
Message-ID: <20130109015112.GA6496@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 31, 2012 at 12:23:54PM +0100, Guennadi Liakhovetski wrote:
> Add a DT-only mackerel implementation. So far it only contains a limited
> set of devices, already implementing DT support. As more drivers are
> extended with DT initialisation option, respective devices shall be added
> to sh7372-mackerel-reference.dts.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Guennadi,

thanks. This looks good to me.
I will apply it once I have applied the INTC and pinmux changes.
