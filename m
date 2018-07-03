From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 03 Jul 2018 11:20:40 +0200
Subject: [PATCH v2 1/2] clk: meson-axg: add pcie and mipi clock bindings
In-Reply-To: <20180702213118.19222-2-yixun.lan@amlogic.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
 <20180702213118.19222-2-yixun.lan@amlogic.com>
Message-ID: <1530609640.2900.184.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-07-02 at 21:31 +0000, Yixun Lan wrote:
> Add the pcie and mipi clock dt-bindings for the pcie driver.
> 
> Since the mipi clock isalso used by the pcie driver,
> we add it together in this patch.
> 
> Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/clock/axg-clkc.h | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thx
