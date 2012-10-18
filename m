From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 18 Oct 2012 17:59:54 +0530
Subject: [PATCH 0/5] ARM: OMAP2+: PRM/CM cleanup series for 3.8
In-Reply-To: <20121015224455.18306.89030.stgit@dusk.lan>
References: <20121015224455.18306.89030.stgit@dusk.lan>
Message-ID: <507FF642.2010502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 October 2012 04:35 AM, Paul Walmsley wrote:
> Consolidate and remove some PRM/CM code in preparation for a future move
> into drivers/:
>
> - Remove some obsolete weak functions that allowed old OMAP4 code to
>    reference OMAP2/3 PRM functions
>
> - Split many of the functions in prm2xxx_3xxx.c and cm2xxx_3xxx.c into
>    2xxx- and 3xxx-specific PRM/CM C files
>
> - Move low-level powerdomain and clockdomain register access into the
>    appropriate 2xxx- and 3xxx-specific PRM/CM files, and remove
>    {power,clock}domainXXXX.c
>
> This series shouldn't have any functional impact.
>
>
Nice work Paul !!
This series and part2 both looks good to me.
Sorry for not being able to help in some of these clean-ups
because of other work priorities as talked at LPC.
Feel free to add my ack for the whole series if you need one.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
