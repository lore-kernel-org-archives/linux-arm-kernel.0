From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Feb 2016 10:58:37 +0100
Subject: [PATCH v4 0/7] ARM: dts: R-Car: Add SCIF fallback compatibility
 strings
In-Reply-To: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
References: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160202095836.GB15554@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 10:32:01AM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds fallback compatibility strings for SCIF, HSCIF,
> SCIFA, and SCIFB to the dtsi files for R-Car Gen1, Gen2, and Gen3 SoCs.
> These fallback compatibility strings have been accepted in the DT
> bindings in v4.5-rc1.
> 
> This will allow the sh-sci driver to match on family-specific compatible
> values, to enable support for the Baud Rate Generator for External Clock
> (BRG) on (H)SCIF later.
> 
> Changes compared to v3:
>   - Changed one-line summary prefix to match current arm-soc practices,
>   - Rebased on top of renesas-devel-20160129-v4.5-rc1.
> 
> Thanks for applying!

Thanks, I have queue them up.
