From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 16:43:07 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.4
In-Reply-To: <cover.1443072491.git.horms+renesas@verge.net.au>
References: <cover.1443072491.git.horms+renesas@verge.net.au>
Message-ID: <5084387.KxgjSGLa7G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 September 2015 14:30:20 Simon Horman wrote:
>   This part of a multi-stage effort by Geert Uytterhoeven to add:
> 
>   "Clock Domain support to the Clock Pulse Generator (CPG) Module Stop
>    (MSTP) Clocks driver using the generic PM Domain, to be used on shmobile
>    SoCs without device power domains (R-Car Gen1 and Gen2, RZ).  This allows
>    to power-manage the module clocks of SoC devices that are part of the
>    CPG/MSTP Clock Domain using Runtime PM, or for system suspend/resume,
>    similar to SoCs with device power domains (SH-Mobile and R-Mobile)."
> 
> 

Merged into next/soc, thanks!

	Arnd
