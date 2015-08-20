From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 20 Aug 2015 10:45:56 +0530
Subject: [PATCH v8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <1437943855-29055-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437943855-29055-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150820051556.GT13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 26, 2015 at 10:50:55PM +0200, Maxime Ripard wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This patch adds support for the DMA engine present on Allwinner A10,
> A13, A10S and A20 SoCs. This engine has two kinds of channels: normal
> and dedicated. The main difference is in the mode of operation;
> while a single normal channel may be operating at any given time,
> dedicated channels may operate simultaneously provided there is no
> overlap of source or destination.
> 
> Hardware documentation can be found on A10 User Manual (section 12), A13
> User Manual (section 14) and A20 User Manual (section 1.12)

Applied with subsystem name fixed

-- 
~Vinod
