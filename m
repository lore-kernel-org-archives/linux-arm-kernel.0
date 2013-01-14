From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 14 Jan 2013 20:17:26 +0000
Subject: [PATCH v2 01/10] spi: tegra: Do not use clock name to get clock
In-Reply-To: <50F07CF4.2090502@wwwdotorg.org>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
 <50F07CF4.2090502@wwwdotorg.org>
Message-ID: <20130114201726.C11F73E249D@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jan 2013 13:58:28 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/11/2013 01:01 AM, Prashant Gaikwad wrote:
> > Since Tegra spi devices do not have multiple clocks, no need to use
> > clock name to get the clock.
> 
> Cc'ing in the SPI maintainers as an FYI and for Acks; this patch needs
> to go through the Tegra tree due to dependencies.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

No problem merging it via the Tegra tree.

g.
