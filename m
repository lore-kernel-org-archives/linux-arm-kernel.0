From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Jul 2013 14:35:05 +0200
Subject: [GIT PULL 0/2] Renesas ARM based SoC fixes for v3.11
In-Reply-To: <cover.1372739438.git.horms+renesas@verge.net.au>
References: <cover.1372739438.git.horms+renesas@verge.net.au>
Message-ID: <201307031435.05949.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 July 2013, Simon Horman wrote:
> --------------------------------------------------
> Renesas ARM based SoC fixes for v3.11
> 
> * Correct GIO3 base addresses for EMEV2 SoC
>   - This bug bug added when GPIO support was added for the EMEV2 SoC
>     in v3.5
> 
> * Correct SCIFB0 resources for r8a77a4 SoC
>   - This was a bug was added when SCIF support was added for the r8a77a4 SoC
>     in v3.10
> 

Pulled into the fixes branch, thanks!

	Arnd
