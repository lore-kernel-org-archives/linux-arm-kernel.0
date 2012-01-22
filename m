From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 21 Jan 2012 20:47:59 -0700 (MST)
Subject: [PATCH 6/8] ARM: OMAP4: hwmod data: add HDQ/1-wire hwmod
In-Reply-To: <20120121235934.17619.74939.stgit@dusk>
References: <20120121235333.17619.56725.stgit@dusk>
 <20120121235934.17619.74939.stgit@dusk>
Message-ID: <alpine.DEB.2.00.1201212046380.26641@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Sat, 21 Jan 2012, Paul Walmsley wrote:

> Add the hwmod data for the HDQ/1-wire hwmod ('hdq1w').  The scripts have 
> been updated.

just a quick note, I've dropped this patch from the series.  The HDQ 
driver does byte-width accesses, which breaks pretty badly on OMAP4.  A 
patch to fix this will be sent separately, and once that is merged, we'll 
deal with adding the OMAP4 data.


- Paul
