From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 7 Mar 2016 15:34:44 -0300
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
In-Reply-To: <1457375055-5544-1-git-send-email-afaerber@suse.de>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
Message-ID: <CABxcv=kEDoP3_Q3OKh1rGJ3=nFxRydu7L7bv5C=bNbmXyFt8dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On Mon, Mar 7, 2016 at 3:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Drop #address-cells and #size-cells, which are not required by the
> gpio-keys binding documentation, as button sub-nodes are not devices.
>
> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
