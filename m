From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 11 Dec 2017 10:26:54 +0100
Subject: [PATCH v6 4/6] clk: meson: make the spinlock naming more specific
In-Reply-To: <20171211064853.32111-5-yixun.lan@amlogic.com>
References: <20171211064853.32111-1-yixun.lan@amlogic.com>
 <20171211064853.32111-5-yixun.lan@amlogic.com>
Message-ID: <1512984414.334.10.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 14:48 +0800, Yixun Lan wrote:
> Make the spinlock more specific, so better for lockdep
> debugging and ctags/grep.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Yixun,

This change is not related to the main task describe in the cover letter.
Next time, please send it after your series, or before as a dependency to avoid
mixing topics

Thanks
Jerome
