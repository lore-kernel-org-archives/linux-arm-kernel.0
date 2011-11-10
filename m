From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Nov 2011 22:32:33 +0000
Subject: [PATCH 2/5] ARM: restart: omap: use new restart hook XXX WIP XXX
In-Reply-To: <20111109222728.GO31337@atomide.com>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <E1RN6we-0001aR-Qs@rmk-PC.arm.linux.org.uk>
 <20111109222728.GO31337@atomide.com>
Message-ID: <20111110223233.GR12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 02:27:29PM -0800, Tony Lindgren wrote:
> I guess we want the rest of the board files to set .restart
> to omap1_restart or omap_prcm_restart? Do you already have
> some script doing that or do you need some help there?

It's fairly easy to do using my editor and grep to find the files needing
editing.  As you'll notice from the previous message, I've already fixed
this up.

It passes both my OMAP3 and OMAP4 build checks, but I've not yet booted
the results.
