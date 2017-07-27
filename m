From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 27 Jul 2017 15:35:45 +0200
Subject: [PATCH 0/2] clk: meson: gxbb: fix audio divider flags
In-Reply-To: <20170727130940.18005-1-jbrunet@baylibre.com>
References: <20170727130940.18005-1-jbrunet@baylibre.com>
Message-ID: <0aa1d502-473e-637e-7907-e4f805a16ffb@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2017 03:09 PM, Jerome Brunet wrote:
> Two audio clocks incorrectly set divider flags in the hw.init flag.
> Just move these flags where they belong.
> 
> Jerome Brunet (2):
>   clk: meson: gxbb: fix meson cts_amclk divider flags
>   clk: meson: gxbb: fix clk_mclk_i958 divider flags
> 
>  drivers/clk/meson/gxbb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Applied on clk-meson's fixes/drivers

Thx
