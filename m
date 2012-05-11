From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 11 May 2012 12:01:00 +0530
Subject: [PATCH] ARM: OMAP2+: CLEANUP: Remove ARCH_OMAPx ifdef from struct
 dpll_data
In-Reply-To: <1336716163-2960-1-git-send-email-hvaibhav@ti.com>
References: <1336716163-2960-1-git-send-email-hvaibhav@ti.com>
Message-ID: <CAMQu2gxdOo1R7gNZoxf6qzb2Ncv6yiDorFeX40=T14q2n8nWpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 11:32 AM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
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
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
