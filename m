From: hch@lst.de (Christoph Hellwig)
Date: Mon, 25 Sep 2017 14:47:16 +0200
Subject: [PATCH 2/2] of: configure DMA for host1x devices
In-Reply-To: <dd8e9524-1d91-2c8b-a753-086d3ad9f9c9@arm.com>
References: <20170924090454.28116-1-mperttunen@nvidia.com>
 <20170924090454.28116-2-mperttunen@nvidia.com>
 <20170925074448.GB12494@ulmo.fritz.box>
 <dd8e9524-1d91-2c8b-a753-086d3ad9f9c9@arm.com>
Message-ID: <20170925124716.GB8130@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 01:26:46PM +0100, Robin Murphy wrote:
> Alternatively (and modulo Greg's opinion, obviously) it would arguably be
> neatest to handle this at a slightly lower level as below - I only really
> considered this idea after writing the existing fix, but now that I have
> actually written it up I do rather like it.

I also like this much better than hardcoding specific busses.  The only
real downside is that it makes it too easy to add exceptions :)
