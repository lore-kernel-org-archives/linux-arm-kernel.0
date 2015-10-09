From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 15:18:15 +0200
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <5613EF4C.30603@sigmadesigns.com>
References: <560EAA7C.3070302@free.fr> <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com>
Message-ID: <5898159.aPJzsGHAv7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 17:57:00 Marc Gonzalez wrote:
> This patch adds support for Sigma Designs "Tango4" platform, which is
> built around the ARM Cortex A9 MPCore (single and dual core SoCs).
> 
> Tango4 is not to be confused with Tango3, which was built around a
> MIPS 74kf CPU.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> v3 changes: Updated clock tree DT (clk driver submitted)
> 

Looks all reasonable to me now. Can I get an Ack from M?ns? It sounds
like he is the original author of the port.

	Arnd
