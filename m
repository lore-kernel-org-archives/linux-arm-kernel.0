From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Jan 2018 09:51:15 -0600
Subject: [PATCH 10/12] clk: mediatek: switch to use dev_get_regmap() for
 MT7622 audsys
In-Reply-To: <cbdada9cdbafda2452fe171a81588ce5b0d4f688.1514881870.git.ryder.lee@mediatek.com>
References: <cover.1514881870.git.ryder.lee@mediatek.com>
 <cbdada9cdbafda2452fe171a81588ce5b0d4f688.1514881870.git.ryder.lee@mediatek.com>
Message-ID: <20180105155115.xihnhkvlrj3lozsx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 07:47:52PM +0800, Ryder Lee wrote:
> As the new audsys wrapper driver is in place, switch to use dev_get_regmap()
> to obtain the regmap from its parent.
> 
> This patch also add missing clock data 'CLK_AUDIO_AFE_CONN'.

"also" is a keyword for this belonging in a separate patch.

> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt7622-aud.c  | 11 +++++++++--
>  include/dt-bindings/clock/mt7622-clk.h |  3 ++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
