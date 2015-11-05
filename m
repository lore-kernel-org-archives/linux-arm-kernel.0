From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 5 Nov 2015 14:17:31 +0300
Subject: [PATCH/RFC] ARM: shmobile: Introduce ARCH_RENESAS
In-Reply-To: <1446702397-24078-1-git-send-email-horms+renesas@verge.net.au>
References: <1446702397-24078-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <563B3ACB.9050807@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/5/2015 8:46 AM, Simon Horman wrote:

> The purpose of this patch is to start the process of replacing both
> ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI with ARCH_RENESAS. The motivation
> being that as time has moved on Renesas has become a name than shmobile for
> the majority Renesas 32-bit ARM based SoCs.

    Couldn't parse this sentence. :-)

> The name is, conveniently, also
> applicable to (older) Renesas SH based SoCs and (newer) ARM64 based SoCs
> although this patch only addresses 32-bit ARM.
>
> It is envisaged that follow up work may address migrating both
> SH SoCs and drivers from ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI to
> ARCH_RENESAS.
>
> Proposed support for the r8a7795 ARM64 based SoC already uses ARCH_RENESAS
> which selects ARCH_SHMOBILE.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[...]

MBR, Sergei
