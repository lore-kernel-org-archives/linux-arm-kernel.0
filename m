From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 18 Apr 2018 20:18:35 -0700
Subject: [PATCH v1 2/4] dt-bindings: clock: mediatek: add g3dsys bindings
In-Reply-To: <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
References: <cover.1524044917.git.sean.wang@mediatek.com>
 <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
Message-ID: <152410791532.46528.10083030894445315558@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting sean.wang at mediatek.com (2018-04-18 03:24:54)
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add bindings to g3dsys providing necessary clock and reset control to
> Mali-450.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 ++++++++++++++++++++++

Why isn't this under bindings/clock/ ?
