From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 22 Nov 2012 16:50:38 +0530
Subject: [PATCH 133/493] remove use of __devexit_p
In-Reply-To: <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
Message-ID: <CA+V-a8sT2DrF0+HTDhe7_2JEbpxC79y8ayfLb-t3ovTchVXvzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:51 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
[snip]

>  drivers/media/platform/davinci/dm355_ccdc.c              | 2 +-
>  drivers/media/platform/davinci/dm644x_ccdc.c             | 2 +-
>  drivers/media/platform/davinci/isif.c                    | 2 +-
>  drivers/media/platform/davinci/vpbe_display.c            | 2 +-
>  drivers/media/platform/davinci/vpfe_capture.c            | 2 +-
>  drivers/media/platform/davinci/vpif.c                    | 2 +-
>  drivers/media/platform/davinci/vpss.c                    | 2 +-

Acked-by: Prabhakar Lad <prabhakar.lad@ti.com>
