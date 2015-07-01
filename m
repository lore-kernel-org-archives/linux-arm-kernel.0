From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 01 Jul 2015 13:44:14 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v4.2
In-Reply-To: <5592A03B.5020900@free-electrons.com> (Gregory CLEMENT's message
 of "Tue, 30 Jun 2015 15:57:15 +0200")
References: <5592A03B.5020900@free-electrons.com>
Message-ID: <7hr3orliap.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> Hi,
>
> Here is a small pull request for fixes for mvebu for v4.2.
> It would be nice to have them in v4.2-rc1. It combines two signed
> tags: the new one mvebu-fixes-4.2-0 and the previous one which has not
> been pulled for 4.1: mvebu-fixes-4.1-4
>
> Gregory
>
> The following changes since commit 885dbd154b2f2ee305cec6fd0a162e1a77ae2b06:
>
>   Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window" (2015-05-28 11:14:31 +0200)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.2-0
>
> for you to fetch changes up to 5d6bed2a9c8bc161bff4cc7cede00f2e0e27a7e7:
>
>   ARM: dove: fix legacy dove IRQ numbers (2015-06-24 11:05:57 +0200)
>
> ----------------------------------------------------------------
> mvebu fixes for 4.2 (part 0)
>
> Fix legacy dove IRQ numbers
>
> ----------------------------------------------------------------

Pulled into next/late, which might make it for -rc1, but if not, will
make it into -rc2.

Thanks,

Kevin
