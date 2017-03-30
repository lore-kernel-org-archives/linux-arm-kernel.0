From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu, 30 Mar 2017 12:48:18 +0200
Subject: [PATCH/RFC v2 0/2] arm64: dts: r8a7795: Add support for R-Car
 H3 ES2.0
In-Reply-To: <1490362665-4422-1-git-send-email-geert+renesas@glider.be>
References: <1490362665-4422-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1490870898.3471.3.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-24 at 14:37 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds preliminary support for Renesas Salvator-X
> development boards equipped with revision ES2.0 of the R-Car H3 Soc.
> 
> ? - Patch 1 adds support for the R-Car H3 ES2.0 Soc,
> ????While this patch is safe as-is, as it doesn't affect any existing
> ????setups, it's probably a bit premature to apply it.
> ? - Patch 2 adds support for Salvator-X boards with R-Car H3 ES2.0.
> ????This patch does affect existing development setups, as it changes
> the
> ????name of the DTB for Salvator-X boards equipped with ES1.x SoCs.
> ????Given most developers have access to ES1.x only, this patch must
> not be
> ????applied yet.

Would it make more sense to add a new r8a7795-es2.dtsi and keep the
current dtsi for es1? Having to load different device-trees based on
which kernel is used would be rather nasty.

-- 
Sjoerd Simons
Collabora Ltd.
