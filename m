From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 31 Oct 2011 21:38:59 +0000
Subject: [PATCH] regulator: Use regmap_read/write(), regmap_update_bits
	functions directly
In-Reply-To: <1319617556-29021-1-git-send-email-jhbird.choi@samsung.com>
References: <1319617556-29021-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <20111031213859.GA22025@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2011 at 05:25:56PM +0900, jhbird.choi at samsung.com wrote:
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

Please make sure you CC Liam on all regulator API patches - you should
CC all the maintainers for the subsystem.  This needs to be refreshed
against current -next, it won't apply as-is (I suspect the patch is for
3.0 rather than current code).
