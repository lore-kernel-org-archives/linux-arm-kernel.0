From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Nov 2016 19:14:44 +0100
Subject: [PATCH] drm/sun4i: Fix error handling
In-Reply-To: <c15282b4-e88a-06b1-527d-96aedce8b7eb@wanadoo.fr>
References: <20161030084926.15303-1-christophe.jaillet@wanadoo.fr>
 <c15282b4-e88a-06b1-527d-96aedce8b7eb@wanadoo.fr>
Message-ID: <20161102181444.hfrh6fcr2a5oe5n4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 30, 2016 at 12:53:02PM +0100, Christophe JAILLET wrote:
> BTW, memory allocation in 'sun4i_layers_init()' looks spurious, especially
> the use of 'layer' in the for loop.
> Just my 2 cents.

What do you mean by it's spurious?

> I also forgot to say that we could propagate the error code returned by
> sun4i_layers_init instead of returning -EINVAL unconditionally

Indeed. Can you send a patch for that?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/4e98b055/attachment.sig>
