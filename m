From: zbr@ioremap.net (Evgeniy Polyakov)
Date: Wed, 2 May 2012 19:34:32 +0400
Subject: [PATCH] W1: OMAP HDQ1W: allow driver to be built on all OMAP2+
In-Reply-To: <alpine.DEB.2.00.1205020206020.19695@utopia.booyaka.com>
References: <alpine.DEB.2.00.1205020206020.19695@utopia.booyaka.com>
Message-ID: <20120502153432.GA15534@ioremap.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 02:08:36AM -0600, Paul Walmsley (paul at pwsan.com) wrote:
> 
> Allow the OMAP HDQ1W driver to be built for all OMAP2+ SoCs by
> adjusting KConfig dependencies.  The previous dependency required
> either SOC_OMAP2430 or ARCH_OMAP3 to be set, but the HDQ IP block is
> present on OMAP2420 and OMAP44xx SoCs.  The driver was still
> selectable on multi-OMAP kernel configurations, however; so the
> previous prohibition was rather pointless.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Evgeniy Polyakov <zbr@ioremap.net>

Well, looks good, although I know nothing about build deps for OMAP platform :)

-- 
	Evgeniy Polyakov
