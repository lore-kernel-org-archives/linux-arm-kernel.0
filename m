From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 11 Feb 2016 13:01:36 +0100
Subject: [PATCH V5 08/11] soc: mediatek: PMIC wrap: remove
 pwrap_is_mt8135() and pwrap_is_mt8173()
In-Reply-To: <1454841778-35529-9-git-send-email-blogic@openwrt.org>
References: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
 <1454841778-35529-9-git-send-email-blogic@openwrt.org>
Message-ID: <56BC7820.6040203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/02/16 11:42, John Crispin wrote:
> With more SoCs being added the list of helper functions like these would
> grow. While at it also add a new flag "has_bridge" and use that instead of
> pwrap_is_mt8173() where appropriate.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---

Same here, please explain better what the code does.

Thanks.
Matthias
