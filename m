From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 15:30:00 -0800
Subject: [PATCH] ARM: OMAP2+: Remove legacy macros for zoom platforms
In-Reply-To: <1392198352.23759.10.camel@x220>
References: <1392198352.23759.10.camel@x220>
Message-ID: <20140213233000.GT28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [140212 01:48]:
> Commit 97411608fd5f ("ARM: OMAP2+: Remove legacy support for zoom
> platforms") removed the Kconfig symbols MACH_OMAP_ZOOM2 and
> MACH_OMAP_ZOOM3. Remove the last usage of the related macros too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested, but should have zero impact.

Thanks applying into omap-for-v3.14/fixes.

Tony
