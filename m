From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 14:32:22 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.3
In-Reply-To: <cover.1443752733.git.horms+renesas@verge.net.au>
References: <cover.1443752733.git.horms+renesas@verge.net.au>
Message-ID: <16886284.6TliZiZDrK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 October 2015 11:29:28 Simon Horman wrote:
> 
> Please consider these Renesas ARM based SoC fixes for v4.3.
> 
> These changes are required to restore working sound for the r8a779[01] SoCs
> in v4.3.
> 
> My understanding is that with the inclusion of
> "drivers: sh: Disable PM runtime for multi-platform ARM with genpd"
> in v4.3-rc3 sound stopped working for the SoCs in question.
> 
> These patches were previously posted as part of
> "Renesas ARM Based SoC DT Updates for v4.4".
> I have withdrawn that pull request.
> 
> 

Merged into fixes, thanks!

	Arnd
