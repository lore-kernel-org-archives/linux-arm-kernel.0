From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 09:00:58 -0600
Subject: [PATCH 01/14] pinctrl: sunxi: Add A83T R_PIO controller support
In-Reply-To: <1454203266-4450-2-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-2-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160201150058.GA3209@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 09:20:53AM +0800, Vishnu Patekar wrote:
> The A83T has R_PIO pin controller, it's same as A23, execpt A83T
> interrupt bit is 6th and A83T has one extra pin PL12.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/sunxi/Kconfig                      |   5 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c       | 119 +++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
