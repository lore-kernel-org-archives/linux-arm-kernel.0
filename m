From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 13:14:45 -0700
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.18
In-Reply-To: <5AF5A94A.4080308@hisilicon.com>
References: <5AF5A94A.4080308@hisilicon.com>
Message-ID: <20180514201445.6sglddhalvclu36v@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On Fri, May 11, 2018 at 03:31:38PM +0100, Wei Xu wrote:
> Hi Arnd, Hi Olof,
> 
> Please help to pull the following changes.
> 
> About the CLOCK_STUB and the MAILBOX consolidate patch,
> Jassi and Stephen have acked it.
> Could you let me know how to handle this kind case
> if it is not OK to be in this pull?

I don't think there's any need to group the Kconfig changes with the defconfig
updates here, is there?

So, the clk Kconfig change can go in through the clk maintainer (in one patch),
the mailbox can go in through that maintainer as a separate patch. The update
to the defconfig is just removing what's now the new default, so it's not
urgent to do.

Based on this, can you respin the pull request with that patch dropped? Thanks!


-Olof
