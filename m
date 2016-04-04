From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Apr 2016 14:16:20 -0700
Subject: [PATCH v4 2/3] dmaengine: sun6i: Set default maxburst size and
 bus width
In-Reply-To: <dbffa01a982303114e5ae377189ddfa9fdff4999.1459590553.git.moinejf@free.fr>
References: <cover.1459590553.git.moinejf@free.fr>
 <dbffa01a982303114e5ae377189ddfa9fdff4999.1459590553.git.moinejf@free.fr>
Message-ID: <20160404211620.GO4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2016 at 11:27:57AM +0200, Jean-Francois Moine wrote:
> Some DMA clients, as audio, don't set the maxburst size and bus width
> on the memory side when starting DMA transfers.
> This patch prevents such transfers to be aborted by providing system
> default values to the lacking ones.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/d575b3c2/attachment.sig>
