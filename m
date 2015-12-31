From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Dec 2015 17:00:49 +0100
Subject: [PATCH 0/1 for 4.4-rc8] ARM: Fix broken USB support in
 sunxi_defconfig
In-Reply-To: <4865776.yyMBHQfnua@wuerfel>
References: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
 <4865776.yyMBHQfnua@wuerfel>
Message-ID: <20151231160049.GA23528@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Dec 31, 2015 at 04:46:01PM +0100, Arnd Bergmann wrote:
> On Tuesday 29 December 2015 02:47:32 Timo Sigurdsson wrote:
> > Here is a late patch aimed for 4.4-rc8 (or 4.4). It would be nice if this   
> > could make it into 4.4 in order to avoid unpleasent surprises (and
> > subsequent questions) with builds based on sunxi_defconfig. At the moment,
> > some boards (e.g. LeMaker BananaPi) are left with non-functional USB ports
> > as a newly added driver is required to power them.
> 
> It's a bit confusing to send a patch to so many recipients, that usually
> leads to nobody applying it. I can put it into the fixes branch in arm-soc
> but need an Ack from the sunxi maintainer(s).

You have mine

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Timo, don't we need the same thing for multi_v7?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151231/64e93d12/attachment-0001.sig>
