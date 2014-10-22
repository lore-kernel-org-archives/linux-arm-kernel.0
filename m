From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 22 Oct 2014 01:30:01 -0700
Subject: [PATCH v2 2/5] spi-nor: Remove spi_nor::read_id operation
In-Reply-To: <1412043304.9388.83.camel@decadent.org.uk>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043304.9388.83.camel@decadent.org.uk>
Message-ID: <20141022083001.GE16128@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 03:15:04AM +0100, Ben Hutchings wrote:
> There is currently no useful way to override the default
> implementation of this operation.  The returned struct spi_device_id
> must have a pointer to struct flash_info in its private data, but this
> structure is defined inside spi-nor.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied this one to l2-mtd.git. Thanks!

Brian
