From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 3 May 2016 15:37:47 +0530
Subject: [PATCH 1/7] reset: add devm_reset_controller_register API
In-Reply-To: <1462099023-11819-2-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
 <1462099023-11819-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <57287873.7040504@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sunday 01 May 2016 04:06 PM, Masahiro Yamada wrote:
> Add a device managed API for reset_controller_register().
>
> This helps in reducing code in .remove callbacks and sometimes
> dropping .remove callbacks entirely.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>


I liked it.
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
