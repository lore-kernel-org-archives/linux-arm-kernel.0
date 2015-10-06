From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Oct 2015 05:06:06 -0700
Subject: [PATCH 01/17] ARM: OMAP2+: PRM: add support for reset controller
In-Reply-To: <1443104818-993-2-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
 <1443104818-993-2-git-send-email-t-kristo@ti.com>
Message-ID: <20151006120606.GP23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150924 07:30]:
> PRM driver now supports reset controller for the defined reset lines.
> Reset configurations are provided through device tree. Later, functionality
> like hwmod and system reboot will be changed to use the generic framework.

This approach seems good to me in general. This should have the related
reset driver documentation too for the binding though.

Regards,

Tony
