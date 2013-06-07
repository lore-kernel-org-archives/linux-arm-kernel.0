From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Jun 2013 13:52:19 -0700
Subject: [PATCH 4/4] ARM: OMAP: Move DT wake-up event handling over to
 use pinctrl-single-omap
In-Reply-To: <20130607205046.16513.2802.stgit@localhost>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205046.16513.2802.stgit@localhost>
Message-ID: <20130607205219.GG3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130607 13:56]:
> Now pinctrl-single-omap can handle the wake-up events for us now
> as long as the events are configured in the .dts files.

This patch I should queue separately, the rest should go via
the pinctrl tree.

Regards,

Tony
