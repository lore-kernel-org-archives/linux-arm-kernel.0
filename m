From: milo.kim@ti.com (Kim, Milo)
Date: Mon, 15 Feb 2016 08:37:47 +0900
Subject: [PATCH v2 2/4] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1454697741-8687-3-git-send-email-contact@paulk.fr>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
 <1454697741-8687-3-git-send-email-contact@paulk.fr>
Message-ID: <56C10FCB.5070803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/6/2016 3:42 AM, Paul Kocialkowski wrote:
> LP872x regulators are made active via the EN pin, which might be hooked to a
> GPIO. This adds support for driving the GPIO high when the driver is in use.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   .../devicetree/bindings/regulator/lp872x.txt       |  1 +
>   drivers/regulator/lp872x.c                         | 34 ++++++++++++++++++++++
>   include/linux/regulator/lp872x.h                   |  5 ++++
>   3 files changed, 40 insertions(+)

Acked-by: Milo Kim <milo.kim@ti.com>

Best regards,
Milo
