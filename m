From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Feb 2016 15:07:38 +0100
Subject: [PATCH 0/2] ARM: shmobile: Remove legacy machine_desc.map_io()
 callbacks
In-Reply-To: <1453994246-12886-1-git-send-email-geert+renesas@glider.be>
References: <1453994246-12886-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160202140738.GC4304@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 04:17:24PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series removes the legacy machine_desc.map_io() callback for
> SoCs that no longer rely on it, but use ioremap() instead.
> 
> The patch for emev2 depends on "ARM: shmobile: Consolidate SCU mapping
> code" ("FIXME" commit ID reference to be updated).
> 
> Thanks!

Thanks, I have queued these up.
