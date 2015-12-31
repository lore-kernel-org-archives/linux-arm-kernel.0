From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 16:46:01 +0100
Subject: [PATCH 0/1 for 4.4-rc8] ARM: Fix broken USB support in
 sunxi_defconfig
In-Reply-To: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
References: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <4865776.yyMBHQfnua@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 December 2015 02:47:32 Timo Sigurdsson wrote:
> Here is a late patch aimed for 4.4-rc8 (or 4.4). It would be nice if this   
> could make it into 4.4 in order to avoid unpleasent surprises (and
> subsequent questions) with builds based on sunxi_defconfig. At the moment,
> some boards (e.g. LeMaker BananaPi) are left with non-functional USB ports
> as a newly added driver is required to power them.

It's a bit confusing to send a patch to so many recipients, that usually
leads to nobody applying it. I can put it into the fixes branch in arm-soc
but need an Ack from the sunxi maintainer(s).

	Arnd
