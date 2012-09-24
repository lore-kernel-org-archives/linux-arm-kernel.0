From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 24 Sep 2012 16:34:24 +0200
Subject: [PATCH] ARM: OMAP: hwmod: align the SmartReflex fck names
In-Reply-To: <1348134503-28220-1-git-send-email-j-pihet@ti.com>
References: <1348134503-28220-1-git-send-email-j-pihet@ti.com>
Message-ID: <CAORVsuUYh=WuazYePE1PMY9aXn2=Ropp3cOVi3EgqRe34nWz9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul, Kevin,

On Thu, Sep 20, 2012 at 11:48 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> Rename the smartreflex fck names:
> - for consistency and better readability,
> - for use by the SmartReflex driver, through the hwmod .main_clk
>   field.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Please discard this version. I have a new version ready after Tony's
comments on the SmartReflex patches [1]

[1] http://marc.info/?l=linux-omap&m=134825443710207&w=2

Re-submitting in a bit.
> ---
>  arch/arm/mach-omap2/clock3xxx_data.c       |   12 ++++++------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>

Regards,
Jean
