From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Wed, 12 Jun 2013 10:16:15 +0900
Subject: [PATCH v3 3/7] mmc: dw_mmc-pltfm: move probe and remove below dt
 match table
In-Reply-To: <201306111330.28759.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de>
 <201306111330.28759.heiko@sntech.de>
Message-ID: <000901ce670a$6f96a2c0$4ec3e840$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/13 2013 8:30 PM Heiko St?bner wrote:
> In a subsquent patch probe will need to do some handling of data from
> the dt match table. So to prevent the need for forward declarations,
> move probe and remove below the match table.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
