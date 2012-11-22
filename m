From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Nov 2012 14:12:41 +0800
Subject: [PATCH v2 1/3] CLK: get rid of HAVE_CLK_PREPARE
In-Reply-To: <1353562482-12422-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353562482-12422-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353562482-12422-2-git-send-email-dmitry.torokhov@gmail.com>
Message-ID: <20121122061238.GB24693@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 09:34:40PM -0800, Dmitry Torokhov wrote:
> HAVE_CLK_PREPARE is automatically selected by COMMON_CLK and the only
> platform that explicitly selects HAVE_CLK_PREPARE is MXS which has been
> switched to common clk framework, so we can delete this option now.
> 
> As part of this change we move declarations of clk_prepare() and
> clk_unprepare() under HAVE_CLK and provide stubs if this option is not
> enabled.
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
