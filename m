From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Jun 2015 16:31:11 +0530
Subject: [PATCH v2 2/3] dmaengine: at_xdmac: rework slave configuration
 part
In-Reply-To: <1433752399-26231-2-git-send-email-ludovic.desroches@atmel.com>
References: <1433751820-26142-1-git-send-email-ludovic.desroches@atmel.com>
 <1433752399-26231-1-git-send-email-ludovic.desroches@atmel.com>
 <1433752399-26231-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150608110111.GH28601@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 10:33:15AM +0200, Ludovic Desroches wrote:
> Rework slave configuration part in order to more report wrong errors
> about the configuration.
> Only maxburst and addr width values are checked when doing the slave
> configuration. The validity of the channel configuration is done at
> prepare time.

Applied, thanks

-- 
~Vinod
