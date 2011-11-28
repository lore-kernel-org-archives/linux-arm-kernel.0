From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Nov 2011 19:02:29 +0000
Subject: [PATCH 2/5] regulator: fix label names used in device tree
 bindings
In-Reply-To: <1322487439-27254-3-git-send-email-shawn.guo@linaro.org>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
 <1322487439-27254-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111128190228.GD1586@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 09:37:16PM +0800, Shawn Guo wrote:
> Device tree compiler does not recognize '-' in label name.  Instead,
> '_' works fine.

Applied, thanks.
