From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 16 Mar 2016 11:47:56 -0300
Subject: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
In-Reply-To: <1458129209-15449-1-git-send-email-afaerber@suse.de>
References: <1458129209-15449-1-git-send-email-afaerber@suse.de>
Message-ID: <CABxcv=kSax5=5mOWT7ktavFQHvdp=sxZNcJaqc=nRQN-DejnVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On Wed, Mar 16, 2016 at 8:53 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Drop #address-cells and #size-cells, which are not required by the
> gpio-keys binding documentation, as button sub-nodes are not devices.
>
> Rename sub-nodes to avoid new dtc unit address warnings when copied.
>
> While at it, adopt the dashes convention for the node name.
>
> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> Cc: Julien Chauveau <chauveau.julien@gmail.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
