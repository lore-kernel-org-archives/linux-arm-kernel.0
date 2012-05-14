From: khilman@ti.com (Kevin Hilman)
Date: Mon, 14 May 2012 15:24:11 -0700
Subject: [PATCH] ARM: OMAP2+: CLEANUP: Remove ARCH_OMAPx ifdef from struct
 dpll_data
In-Reply-To: <1336716163-2960-1-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Fri, 11 May 2012 11:32:43 +0530")
References: <1336716163-2960-1-git-send-email-hvaibhav@ti.com>
Message-ID: <87zk9apfjo.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> From: Kevin Hilman <khilman@ti.com>
>
> There are certain fields inside 'struct dpll_data' which are
> included under ARCH_OMAP3 and ARCH_OMAP4 option, which makes it
> difficult to use it for new devices like, am33xx, ti81xx, etc...
>
> So remove the ifdef completely, this will add few fields to the struct
> unused, but it improves readability and maintainability of the code.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: R Sricharan <r.sricharan@ti.com>
> ---
> Since Kevin had provided this idea and code change,
> making this patch under his authorship.

Be sure to give yourself credit for writing the changelog.  Normally, if
you make changes/additions to patch, you can add a line just before your
signoff.  Something like:

[hvaibhav at ti.com: wrote detailed changelog]

Kevin
