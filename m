From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Jul 2015 05:58:00 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: Remove legacy OMAP3 ISP instantiation
In-Reply-To: <1437051319-9904-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1437051319-9904-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1437051319-9904-2-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20150716125800.GN17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [150716 05:57]:
> The OMAP3 ISP is now fully supported in DT, remove its instantiation
> from C code.

Please feel to queue this along with the second patch in this series,
this should not cause any merge conflicts:

Acked-by: Tony Lindgren <tony@atomide.com>
