From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 19 Nov 2013 15:23:54 -0800
Subject: [PATCH 25/31] serial: tegra: convert to standard DMA DT bindings
In-Reply-To: <1384548866-13141-26-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-26-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131119232354.GB24947@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:20PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> By using dma_request_slave_channel_or_err(), the DMA slave ID can be
> looked up from standard DT properties, and squirrelled away during
> channel allocation. Hence, there's no need to use a custom DT property
> to store the slave ID.
> 
> DMA channel allocation is moved to probe() so that deferred probe works.
> 
> Cc: treding at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
