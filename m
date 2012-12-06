From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 6 Dec 2012 13:24:02 +0530
Subject: [PATCH 234/493] media: remove use of __devinit
In-Reply-To: <1353349642-3677-234-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-234-git-send-email-wfp5p@virginia.edu>
Message-ID: <CA+V-a8u05u-kZUtx758yJSkXGWfgxLEqXnd7G2gDB5hWwhuB=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:53 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> ---
[Snip]
...
>  drivers/media/platform/davinci/dm355_ccdc.c        |  2 +-
>  drivers/media/platform/davinci/dm644x_ccdc.c       |  2 +-
>  drivers/media/platform/davinci/isif.c              |  2 +-
>  drivers/media/platform/davinci/vpbe.c              |  2 +-
>  drivers/media/platform/davinci/vpbe_display.c      |  6 ++---
>  drivers/media/platform/davinci/vpfe_capture.c      |  2 +-
>  drivers/media/platform/davinci/vpif.c              |  2 +-
>  drivers/media/platform/davinci/vpss.c              |  2 +-

Acked-by: Prabhakar Lad <prabhakar.lad@ti.com>

Regards,
--Prabhakar

> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
