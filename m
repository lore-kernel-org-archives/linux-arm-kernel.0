From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jun 2013 09:19:09 +0100
Subject: amba-pl08x and 'get_signal' namespace collision/build error
In-Reply-To: <20130626044842.GR23141@intel.com>
References: <51C97F40.5030101@arm.com>
 <20130625184539.GB2718@n2100.arm.linux.org.uk>
 <20130626044842.GR23141@intel.com>
Message-ID: <20130626081909.GD2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 10:18:42AM +0530, Vinod Koul wrote:
> Yup. This is fixed in slave-dma tree by a patch from mark by renaming it.
> 
> This should not show in the -next tree

Except, that change probably is probably responsible for this new error:

drivers/dma/amba-pl08x.c: In function 'pl08x_request_mux':
drivers/dma/amba-pl08x.c:304:13: error: expected identifier before '(' token
