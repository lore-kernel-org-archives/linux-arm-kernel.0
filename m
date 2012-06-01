From: nm@ti.com (Menon, Nishanth)
Date: Fri, 1 Jun 2012 05:13:18 -0500
Subject: [PATCHv3 2/9] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add
 recursive usecount tracking
In-Reply-To: <1338470942-20185-3-git-send-email-t-kristo@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
 <1338470942-20185-3-git-send-email-t-kristo@ti.com>
Message-ID: <CAOMWX4dPQGw=_u5HvD8T9cJ1aSo8tTsmok+bj2Op5TWtbp9R4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 8:28 AM, Tero Kristo <t-kristo@ti.com> wrote:
minor comment:
> +void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
<snip>
> +void pwrdm_clkdm_disable(struct powerdomain *pwrdm)

I know the understand that rest of the code lacks kernel-doc, but at
least can we ensure that the new functions does?

Regards,
Nishanth Menon
