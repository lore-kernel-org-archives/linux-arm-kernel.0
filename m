From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 13:36:11 -0600
Subject: [PATCH 5/9] spi: tegra20-sflash: move to generic dma DT binding
In-Reply-To: <1374639002-16753-6-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-6-git-send-email-rizhao@nvidia.com>
Message-ID: <51F2CFAB.4000609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 10:09 PM, Richard Zhao wrote:
> update binding doc.

It may be worth mentioning here that the driver isn't updated since it
doesn't support DMA operation (yet?). A more complete patch description
would also be useful.
