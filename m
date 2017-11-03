From: horms@verge.net.au (Simon Horman)
Date: Fri, 3 Nov 2017 09:04:39 +0100
Subject: [PATCH] ARM: dts: koelsch: Move cec_clock to root node
In-Reply-To: <14112514.nMv28tbzn2@avalon>
References: <20171102091805.24967-1-horms+renesas@verge.net.au>
 <14112514.nMv28tbzn2@avalon>
Message-ID: <20171103080438.2lxcheqyqrg6jfld@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 07:39:18PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Thursday, 2 November 2017 11:18:05 EET Simon Horman wrote:
> > cec-clock is a fixed clock generator that is not controlled by i2c5 and
> > thus should not be a child of the i2c5 bus node. Rather, it should be
> > a child of the root node of the DT.
> > 
> > Fixes: 02a5ab18d366 ("ARM: dts: koelsch: Add CEC clock for HDMI
> > transmitter") Reported-by: Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, applied.
