From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 31 Jan 2011 11:05:12 -0700
Subject: [PATCH 0/8] Basic ARM device tree support
In-Reply-To: <00bcd596-2108-4c54-92d3-7fda39e333e3@VA3EHSMHS015.ehs.local>
References: <20110118195933.13011.56098.stgit@localhost6.localdomain6>
	<00bcd596-2108-4c54-92d3-7fda39e333e3@VA3EHSMHS015.ehs.local>
Message-ID: <20110131180512.GA15429@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 01:04:39PM -0700, John Linn wrote:
> > -----Original Message-----
> > From: Grant Likely [mailto:glikely at secretlab.ca] On Behalf Of Grant Likely
> > Sent: Tuesday, January 18, 2011 1:29 PM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: Nicolas Pitre; Russell King; Catalin Marinas; devicetree-discuss at lists.ozlabs.org; linux-
> > kernel at vger.kernel.org; Olof Johansson; Jeremy Kerr; John Linn; Lennert Buijtenhek
> > Subject: [PATCH 0/8] Basic ARM device tree support
> > 
> 
> Thanks for this patch set.  Device tree on ARM will be a great help to Xilinx.
> 
> Tested-by: John Linn <john.linn@xilinx.com>

Thanks John,

I've had to rework the early init code to be safer, but it turned out
to be a significant change, so I won't add your tested-by line to the
patch yet.  Would you mind retesting when I repost later today?

Thanks,
g.
