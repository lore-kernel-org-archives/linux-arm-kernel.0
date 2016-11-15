From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Nov 2016 18:53:37 +0100
Subject: [PATCH v3 00/11] soc: renesas: Identify SoC and register with
 the SoC bus
In-Reply-To: <1479148637-5399-1-git-send-email-geert+renesas@glider.be>
References: <1479148637-5399-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20161115175336.GA4065@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 07:37:06PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> Some Renesas SoCs may exist in different revisions, providing slightly
> different functionalities (e.g. R-Car H3 ES1.x and ES2.0), and behavior
> (errate and quirks).  This needs to be catered for by drivers and/or
> platform code.  The recently proposed soc_device_match() API is a good
> fit to handle this.
> 
> This patch series implements the core infrastructure to provide SoC and
> revision information through the SoC bus for Renesas ARM SoCs.

For the record I have queued this up.
