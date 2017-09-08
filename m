From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Sep 2017 15:29:32 +0200
Subject: [PATCH 1/8] ARM: dts: sun6i: Fix endpoint IDs in second display
 pipeline
In-Reply-To: <20170908075016.18657-2-wens@csie.org>
References: <20170908075016.18657-1-wens@csie.org>
 <20170908075016.18657-2-wens@csie.org>
Message-ID: <20170908132932.rfz4hxab4tgntioo@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 08, 2017 at 03:50:09PM +0800, Chen-Yu Tsai wrote:
> When the second display pipeline device nodes for the A31/A31s were
> added, it was not known that the TCONs could (through either DRCs)
> select either backend as their input. Thus in the endpoints connecting
> these components together, the endpoint IDs were set to 0, while in
> fact they should have been set to 1.
> 
> Fixes: 9a26882a7378 ("ARM: dts: sun6i: Add second display pipeline device
> 		      nodes")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Should we CC stable on this one?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170908/5a782b8e/attachment.sig>
