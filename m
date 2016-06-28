From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Jun 2016 00:06:06 -0700
Subject: [RESEND PATCHv2 08/28] ARM: OMAP2+: clockdomain: add usecounting
 support to autoidle APIs
In-Reply-To: <1465844702-12200-9-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-9-git-send-email-t-kristo@ti.com>
Message-ID: <20160628070605.GG28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160613 12:08]:
> The previous implementation was racy in many locations, where the current
> status of the clockdomain was read out, some operations were executed,
> and the previous status info was used afterwards to decide next state
> for the clockdomain. Instead, fix the implementation of the allow_idle /
> deny_idle APIs to properly have usecounting support. This allows clean
> handling internally within the clockdomain core, and simplifies the
> usage also within hwmod.

Acked-by: Tony Lindgren <tony@atomide.com>

Or let me know if this can be picked separately.

Tony
