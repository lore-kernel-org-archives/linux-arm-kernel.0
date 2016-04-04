From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Apr 2016 14:13:16 -0700
Subject: [PATCH v4 1/3] dmaengine: sun6i: Simplify lli setting
In-Reply-To: <996299d88a877386f7293b5b0eefa583cb68c8ba.1459590553.git.moinejf@free.fr>
References: <cover.1459590553.git.moinejf@free.fr>
 <996299d88a877386f7293b5b0eefa583cb68c8ba.1459590553.git.moinejf@free.fr>
Message-ID: <20160404211316.GN4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2016 at 11:24:45AM +0200, Jean-Francois Moine wrote:
> Checking the DMA config before setting the lli list avoids to do tests
> inside the setting loop.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/d35bb552/attachment.sig>
