From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 22 Aug 2011 23:34:25 +0100
Subject: [PATCH 1/1] ASoC: mxs-saif: clear clk gate first before register
	setting
In-Reply-To: <1313941540-20393-1-git-send-email-b29396@freescale.com>
References: <1313941540-20393-1-git-send-email-b29396@freescale.com>
Message-ID: <20110822223424.GC29473@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 11:45:40PM +0800, Dong Aisheng wrote:
> Saif needs clear clk gate first before writing registers or the write
> will not success.

Applied, thanks.
