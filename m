From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Nov 2016 19:58:30 +0100
Subject: [PATCH v1] ARM:dmaengine:sun6i:fix the uninitialized value for
 v_lli
In-Reply-To: <20161102053112.GA8109@arx-xi>
References: <20161102053112.GA8109@arx-xi>
Message-ID: <20161102185830.7rpjgntogz3c7pls@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 01:31:12PM +0800, Axl-zhang wrote:
> dma_pool_alloc does not initialize the value of the newly allocated
> block for the v_lli, and the uninitilize value make the tests failed
> which is on pine64 with dmatest.
> we can fix it just change the "|=" to "=" for the v_lli->cfg.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/9194dd7d/attachment.sig>
