From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Oct 2012 16:33:57 -0200
Subject: imx-sdma.c broken on imx53 for sound
In-Reply-To: <39c8a3f022e86d3eae0fb7b6e48049f1.squirrel@webmail.efn.org>
References: <39c8a3f022e86d3eae0fb7b6e48049f1.squirrel@webmail.efn.org>
Message-ID: <CAOMZO5B1k4r=6ZqQkZghuEqmEY=tOwRUmZAnckqxBM0_kVf6rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rick,

On Fri, Oct 19, 2012 at 3:07 PM, Rick Bronson <rick@efn.org> wrote:
> Hi,
>
>   On the iMX53, the sound chip sgtl5000 seems to get SDMA channel 0, but
> this code in drivers/dma/imx-sdma.c:
>
>         /* not interested in channel 0 interrupts */
>         if (sdmac->channel == 0)
>                 return;
>
>  causes the DMA to be ignored.  If I comment out the above, I still get no
> sound...
>
>   Anyone have any ideas?

Are you providing the mx53 sdma firmware?

Regards,

Fabio Estevam
