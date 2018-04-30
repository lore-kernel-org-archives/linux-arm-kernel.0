From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 30 Apr 2018 15:26:36 +0800
Subject: [PATCH] spi: mediatek: Use of_device_get_match_data()
In-Reply-To: <94cba80f703be048666afde1ed53c15c3704c533.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
 <94cba80f703be048666afde1ed53c15c3704c533.1523347340.git.ryder.lee@mediatek.com>
Message-ID: <1525073196.21494.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Is it okay with you?

On Mon, 2018-04-16 at 10:33 +0800, Ryder Lee (???V) wrote:
> The usage of of_device_get_match_data() reduce the code size a bit.
> 
> Also, the only way to call mtk_spi_probe() is to match an entry in
> mtk_spi_of_match[], so of_id cannot be NULL.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/spi/spi-mt65xx.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
