From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Mar 2017 11:57:58 +0100
Subject: [PATCH v3 3/4] soc/imx: add new GPC driver
In-Reply-To: <20170217190246.14881-3-l.stach@pengutronix.de>
References: <20170217190246.14881-1-l.stach@pengutronix.de>
 <20170217190246.14881-3-l.stach@pengutronix.de>
Message-ID: <20170308105756.GA17029@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 08:02:45PM +0100, Lucas Stach wrote:
> This is an almost complete re-write of the previous GPC power gating control
> code found in the IMX architecture code. It supports both the old and the new
> DT binding, allowing more domains to be added later and generally makes the
> driver easier to extend, while keeping compatibility with existing DTBs.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

I applied #1 ~ #3, with #2 and #3 merged into one to avoid possible
git bisect issue.

Shawn
