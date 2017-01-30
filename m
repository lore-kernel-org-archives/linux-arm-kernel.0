From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jan 2017 10:09:44 +0100
Subject: [PATCH v3 06/10] clk: sunxi-ng: remove transitional headers for
 dt-bindings
In-Reply-To: <20170129023331.62106-7-icenowy@aosc.xyz>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
 <20170129023331.62106-7-icenowy@aosc.xyz>
Message-ID: <20170130090944.ie76ustqtbtdanli@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 10:33:27AM +0800, Icenowy Zheng wrote:
> As we have already changed the DTSI file, the trnasitional dt-bindings
> header sun8i-h3-ccu.h will not be needed any more.
> 
> Remove them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Your prefix is wrong, this is not part of the clk framework, but
rather the DT one.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/34c1f7ad/attachment.sig>
