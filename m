From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 21:26:45 +0100
Subject: [PATCH 05/17] drm/sun4i: Reorder some code in DE2
In-Reply-To: <20171127205750.19277-6-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-6-jernej.skrabec@siol.net>
Message-ID: <20171128202645.gyf42cdlwebfu66l@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 27, 2017 at 09:57:38PM +0100, Jernej Skrabec wrote:
> While DE2 driver works, parts of the code are not in optimal place. Reorder
> it so it will be easier to support multiple planes.
> 
> This commit doesn't do any functional change besides removing two not
> very useful debug messages.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

So I have the same feeling here that it could be split into several
patches, but you should at least explain why and how that code is more
optimal than it used to.

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/3843501c/attachment.sig>
