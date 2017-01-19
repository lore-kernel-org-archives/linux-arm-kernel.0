From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 19 Jan 2017 16:39:50 +0100
Subject: [PATCH v2 2/4] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <5926181484672894@web12g.yandex.ru>
References: <20170116180116.36729-2-icenowy@aosc.xyz>
 <20170116180116.36729-3-icenowy@aosc.xyz>
 <20170117090456.fgw6lpqgurwwcczj@lukather>
 <5926181484672894@web12g.yandex.ru>
Message-ID: <20170119153950.gosrmbm7jesxljyj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 01:08:14AM +0800, Icenowy Zheng wrote:
> 
> 
> 17.01.2017, 17:05, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > Hi,
> >
> > On Tue, Jan 17, 2017 at 02:01:14AM +0800, Icenowy Zheng wrote:
> >> ?V3s has a similar but cut-down CCU to H3.
> >>
> >> ?Add support for it.
> >>
> >> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> ?---
> >
> > Output from checkpatch:
> > total: 5 errors, 2 warnings, 3 checks, 857 lines checked
> 
> I remembered some errors' code is directly derived from ccu-sun8i-h3.c,
> so I generated a patch file for "clk: sunxi-ng: Add H3 clocks" and run
> checkpatch on it:
> total: 4 errors, 5 warnings, 1159 lines checked
> 
> Should I still get all errors fixed?

Yes, please.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/190589d5/attachment.sig>
