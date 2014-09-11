From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Sep 2014 11:47:59 -0700
Subject: [REPOST PATCHv3] ARM: dts: OMAP2+: Add sub mailboxes device node
 information
In-Reply-To: <1410377243-8147-2-git-send-email-s-anna@ti.com>
References: <1410377243-8147-1-git-send-email-s-anna@ti.com>
 <1410377243-8147-2-git-send-email-s-anna@ti.com>
Message-ID: <20140911184759.GE18849@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [140910 12:28]:
> The sub-mailbox devices are added to the Mailbox DT nodes on
> OMAP2420, OMAP2430, OMAP3, AM33xx, AM43xx, OMAP4 and OMAP5
> family of SoCs. This data represents the same mailboxes that
> used to be represented in hwmod attribute data previously.
> The node name is chosen based on the .name field of
> omap_mbox_dev_info structure used in the hwmod data.

Thanks applying into omap-for-v3.18/dt.

Tony
