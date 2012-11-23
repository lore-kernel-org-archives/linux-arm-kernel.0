From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 23 Nov 2012 04:01:00 +0100
Subject: [PATCH 230/493] input: remove use of __devinit
In-Reply-To: <1353349642-3677-230-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-230-git-send-email-wfp5p@virginia.edu>
Message-ID: <CABxcv==MXEgRpExxDm_Cx4D5bxm5fPR80_2PiU-vzAwcgu31QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:22 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>

>  drivers/input/touchscreen/cyttsp_i2c.c      |  2 +-
>  drivers/input/touchscreen/cyttsp_spi.c      |  2 +-

For these two,

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Thanks

Best regards,
Javier
