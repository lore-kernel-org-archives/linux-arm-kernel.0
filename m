From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 May 2014 14:13:21 -0700
Subject: [PATCH] ARM: OMAP: AM3517EVM: remove check for
 CONFIG_PANEL_SHARP_LQ043T1DG01
In-Reply-To: <1400183692.11786.23.camel@x220>
References: <1400183692.11786.23.camel@x220>
Message-ID: <20140516211321.GG12881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [140515 12:55]:
> The Kconfig symbol PANEL_SHARP_LQ043T1DG01 was removed in v2.6.38. The
> check for CONFIG_PANEL_SHARP_LQ043T1DG01 and its MODULE variant has
> evaluated to false ever since. Remove that check.

Thanks applying into omap-for-v3.16/board.

Tony
