From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 13 Nov 2014 16:59:34 +0000 (UTC)
Subject: [PATCH 0/5] ARM: OMAP3+: DPLL: fix set_rate logic
In-Reply-To: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
References: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1411131629220.31460@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Oct 2014, Tero Kristo wrote:

> OMAP3+ DPLL code is currently using set_rate op to change DPLL rates.
> This is kind of wrong, as it also involves changing DPLL parent in certain
> cases (switch between locked mode <-> bypass mode.) This set fixes these
> issues by introducing the support of determine_rate and set_rate_and_parent
> ops for the DPLL clocks. Also introduces support for set_parent, which
> just switches a DPLL between locked <-> bypass modes.

Thanks, queued for v3.19.


- Paul
