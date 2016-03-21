From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 21 Mar 2016 09:38:16 -0300
Subject: [PATCH] iommu/rockchip: Don't feed NULL res pointers to devres
In-Reply-To: <1458558024-6922-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1458558024-6922-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CABxcv=nhs_3ZRtGAcuLY6L+Tv+BvbDfeX1PYKEipwAsK4YnS+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomeu,

On Mon, Mar 21, 2016 at 8:00 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> If we do, devres prints a "invalid resource" string in the error
> loglevel.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
