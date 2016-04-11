From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Apr 2016 12:40:54 -0700
Subject: [PATCH 0/8] ARM: dts: fixes for DT warnings on OMAP2+ platforms
In-Reply-To: <1459782973-21201-1-git-send-email-t-kristo@ti.com>
References: <1459782973-21201-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160411194053.GC5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160404 08:17]:
> Hi,
> 
> This set fixes the clock node related warnings for OMAP2+ platforms
> that are going to be introduced with the new version of DTC that
> does stricter checks on DT structure. Basically, the address component
> is currently missing on the node names that have a reg properly, which
> is illegal.

Applying into omap-for-v4.7/dt thanks.

Tony
