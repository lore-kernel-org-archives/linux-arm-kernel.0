From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 28 Nov 2013 12:53:11 +0900
Subject: [PATCH v4 2/5] extcon: max14577: Add extcon-max14577 driver to
 support MUIC device
In-Reply-To: <1385135469-27044-3-git-send-email-k.kozlowski@samsung.com>
References: <1385135469-27044-1-git-send-email-k.kozlowski@samsung.com>
 <1385135469-27044-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5296BE27.1040904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2013 12:51 AM, Krzysztof Kozlowski wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch supports Maxim MAX14577 MUIC(Micro USB Interface Controller)
> device by using EXTCON subsystem to handle various external connectors.
> The max14577 device uses regmap method for i2c communication and
> supports irq domain.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/extcon/Kconfig           |   10 +
>  drivers/extcon/Makefile          |    1 +
>  drivers/extcon/extcon-max14577.c |  752 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 763 insertions(+)
>  create mode 100644 drivers/extcon/extcon-max14577.c
> 

Applied it.

Thanks,
Chanwoo Choi
