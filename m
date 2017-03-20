From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 13:50:26 +0100
Subject: [PATCH 0/3] Basical Lichee Pi Zero with Dock support
In-Reply-To: <20170317154343.39921-1-icenowy@aosc.xyz>
References: <20170317154343.39921-1-icenowy@aosc.xyz>
Message-ID: <20170320125026.t35nyadmeupuckc7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 17, 2017 at 11:43:40PM +0800, Icenowy Zheng wrote:
> Lichee Pi Zero have an official dock, which makes use of all stamp hole pins.
> 
> Some extra functionalities are availble via the dock, e.g. an extra
> MMC slot and some keys connected to LRADC.
> 
> This patchset adds the support of these two features of the dock.

I'm a bit skeptical about the whole approach to have a split DTS for
expansion boards.

This is not fundamentally different than having expansion boards, that
we already deal with with overlays. This one is just bigger.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/31466216/attachment.sig>
