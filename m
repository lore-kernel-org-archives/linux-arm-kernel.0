From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 1 Feb 2012 19:29:18 +0530
Subject: [PATCH 0/2] Errata workaround updates
In-Reply-To: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
References: <1328104354-7553-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAMQu2gzErEi_=yBeD-4X6Cf8Kq27nkB94Rkx6q7DG+Pxn9iU3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Wed, Feb 1, 2012 at 7:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hello,
>
> After Russell pointed out that we weren't applying an erratum workaround
> in all cases that it was required:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082730.html
>
> I went back through the documents for PL310 and Cortex-A9 to check that
> what we have in Linux matches the latest workarounds. The only other
> issue I found was that the PL310 workaround we have for #727915 (added
> by Santosh in 2839e06c ("ARM: 6795/1: l2x0: Errata fix for flush by Way
> operation can cause data corrupti") will work only on r3p0, leaving r2p0
> broken. If anybody has an r2p0 version of the PL310, they may like to
> augment the workaround.
>
> While I was at it, I fixed a couple of Kconfig select statements that
> needed updating to identify the correct workaround config option.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Will Deacon (2):
> ?ARM: errata: update workaround for A9 erratum #743622
> ?ARM: errata: fix PL310 erratum #753970 workaround selection
>
The patches look fine to me.
Here is my ack if you need one.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
