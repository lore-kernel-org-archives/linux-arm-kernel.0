From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Dec 2017 16:21:46 +0100
Subject: [PATCH 0/2] Add EHCI/OHCI nodes for V3s and Lichee Pi Zero
In-Reply-To: <20171221150537.20304-1-icenowy@aosc.io>
References: <20171221150537.20304-1-icenowy@aosc.io>
Message-ID: <20171221152146.sotxcq54widpzdde@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 11:05:35PM +0800, Icenowy Zheng wrote:
> As the PHY dual-route property is added to 4.15-rc, the EHCI/OHCI nodes
> are now necessary.
> 
> Please apply these patches to 4.15, Thanks!

There's no reason to have it merged in 4.15. It's not a regression,
so 4.15 should work just as 4.14 worked, right?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171221/214d2041/attachment.sig>
