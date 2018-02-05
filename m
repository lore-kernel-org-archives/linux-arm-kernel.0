From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:08:31 -0600
Subject: [PATCH v2 1/5] clk: mediatek: update missing clock data for
 MT7622 audsys
In-Reply-To: <ec2dfe750291a996c54cc8aaeafafa333b992c4f.1515639336.git.ryder.lee@mediatek.com>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
 <ec2dfe750291a996c54cc8aaeafafa333b992c4f.1515639336.git.ryder.lee@mediatek.com>
Message-ID: <20180205024914.os5dq5wip344hefe@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 03:42:41PM +0800, Ryder Lee wrote:
> Add missing clock data 'CLK_AUDIO_AFE_CONN' for MT7622 audsys.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt7622-aud.c  | 1 +
>  include/dt-bindings/clock/mt7622-clk.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
