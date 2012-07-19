From: nm@ti.com (Menon, Nishanth)
Date: Thu, 19 Jul 2012 02:00:03 -0500
Subject: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
In-Reply-To: <1339428387-4800-5-git-send-email-t-kristo@ti.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
 <1339428387-4800-5-git-send-email-t-kristo@ti.com>
Message-ID: <CAOMWX4ccAJZur1ka89cboYZ8jsXHpvRiBoducgkU1CfdLX52ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor nitpick:

On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
> +/**
> + * _omap4_get_context_lost - get context loss counter for a hwmod
Documentation missing for oh
btw, you might be interested in using http://www.omappedia.org/wiki/Kmake
to provide list of kerneldoc errors in addition to other easily
catchable errors..

> + *
> + * Returns the in-memory context loss counter for a hwmod.
> + */
> +static int _omap4_get_context_lost(struct omap_hwmod *oh)
> +{
> +       return oh->prcm.omap4.context_lost_counter;
> +}


Regards,
Nishanth Menon
