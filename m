From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 22:41:12 +0100
Subject: [GIT PULL v2] Renesas ARM Based SoC Updates for v4.6
In-Reply-To: <cover.1456275652.git.horms+renesas@verge.net.au>
References: <cover.1456275652.git.horms+renesas@verge.net.au>
Message-ID: <9690263.69L9WD628V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 February 2016 10:21:25 Simon Horman wrote:
> Renesas ARM Based SoC Updates for v4.6
> 
> * Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains
> * Move emev2_smp_ops to emev2
> * Remove legacy map_io callbacks on r8a7740 and emev2 SoCs
> * Migrate to generic l2c OF initialization on r8a7740
> 

Pulled into next/soc, thanks! I guess some of it could have been
part of the cleanup branch as well, but it seems fine either way.

	Arnd
