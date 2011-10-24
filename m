From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 24 Oct 2011 15:46:32 +0200
Subject: [PATCH v2] regulator: max8649 Convert max8649 to use regmap api
In-Reply-To: <1319462786-2602-1-git-send-email-jhbird.choi@gmail.com>
References: <1319462786-2602-1-git-send-email-jhbird.choi@gmail.com>
Message-ID: <20111024134632.GC26033@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 10:26:26PM +0900, jhbird.choi at gmail.com wrote:
> From: Jonghwan Choi <jhbird.choi@gmail.com>
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@gmail.com>

Looks good!

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Once the merge window is over it might be useful to look at enabling
register cache for the driver, you'll get a performance improvement as
it'll be able to skip the read part of read/modify/write cycles.
