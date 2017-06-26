From: hch@lst.de (Christoph Hellwig)
Date: Mon, 26 Jun 2017 11:47:39 +0200
Subject: clean up and modularize arch dma_mapping interface V2
In-Reply-To: <1498318616.31581.87.camel@kernel.crashing.org>
References: <20170616181059.19206-1-hch@lst.de>
 <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
 <20170624071855.GD14580@lst.de>
 <1498318616.31581.87.camel@kernel.crashing.org>
Message-ID: <20170626094739.GB13981@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 24, 2017 at 10:36:56AM -0500, Benjamin Herrenschmidt wrote:
> I think we still need to do it. For example we have a bunch new "funky"
> cases.

I have no plan to do away with the selection - I just want a better
interface than the current one.
