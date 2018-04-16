From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Apr 2018 16:35:52 -0500
Subject: [PATCH] pinctrl: mediatek: update pinmux defintions for MT7623
In-Reply-To: <c8748c81711b0d41e83418b6c23d82d8c78c7094.1523845138.git.ryder.lee@mediatek.com>
References: <c8748c81711b0d41e83418b6c23d82d8c78c7094.1523845138.git.ryder.lee@mediatek.com>
Message-ID: <20180416213552.wbtv2ljwqpxgogqx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 10:32:19AM +0800, Ryder Lee wrote:
> Fulfill the pinmux macros for MT7623
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  include/dt-bindings/pinctrl/mt7623-pinfunc.h | 90 +++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
