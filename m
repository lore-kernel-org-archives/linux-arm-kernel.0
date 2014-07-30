From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 30 Jul 2014 21:36:07 +0530
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140730160607.GM8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 06:03:13PM +0200, Maxime Ripard wrote:
> The dmaengine is neither trivial nor properly documented at the moment, which
> means a lot of trial and error development, which is not that good for such a
> central piece of the system.
> 
> Attempt at making such a documentation.

Did you miss Documentation/dmaengine.txt, lots of this is already covered
there. But yes i would be really glad to know what isnt, so that we can fix
that.

> +  * device_slave_caps
> +    - Isn't that redundant with the cap_mask already?
> +    - Only a few drivers seem to implement it
For audio to know what your channel can do rather than hardcoding it

> +
> +  * dma cookies?
cookie is dma transaction representation which is monotonically incrementing
number.

-- 
~Vinod
