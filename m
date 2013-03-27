From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 19:46:40 +0900
Subject: [PATCH 2/3 v3] ARM: shmobile: r8a7778 SCIF support
In-Reply-To: <87620lf4ud.wl%kuninori.morimoto.gx@renesas.com>
References: <87hakhrpmn.wl%kuninori.morimoto.gx@renesas.com>
 <878v5hf4zr.wl%kuninori.morimoto.gx@renesas.com>
 <87620lf4ud.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130327104638.GE413@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:02:38AM -0700, Kuninori Morimoto wrote:
> Add SCIF serial port support to the r8a7778 SoC by
> adding platform devices together with clock bindings.
> DT device description is excluded at this point since
> such bindings are still under development.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued up for v3.10 in the soc branch. 
