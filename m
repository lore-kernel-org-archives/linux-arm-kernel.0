From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Oct 2012 18:34:58 -0200
Subject: imx-sdma.c broken on imx53 for sound
In-Reply-To: <20121029194505.DD38B1A1A4DB@amazonia.comcast.net>
References: <39c8a3f022e86d3eae0fb7b6e48049f1.squirrel@webmail.efn.org>
 <CAOMZO5B1k4r=6ZqQkZghuEqmEY=tOwRUmZAnckqxBM0_kVf6rQ@mail.gmail.com>
 <CAOMZO5BduoMdqvgrARJ4JRVNv2M=+uH24+sHMstssPD2Cxzcfg@mail.gmail.com>
 <20121029194505.DD38B1A1A4DB@amazonia.comcast.net>
Message-ID: <CAOMZO5B4LK2rm5kam-VkFJBpsrCPT27aL4sm_xRgaqeGwx5BuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 5:45 PM, Rick Bronson <rickbronson@gmail.com> wrote:
> Hi Fabio,
>
>   Thanks for the help.  Apparently the firmware moved from internal to
> /lib/firmware/imx/sdma/sdma-imx53.bin

You can generate the mx53 sdma firmware using this tool:
http://git.pengutronix.de/?p=imx/sdma-firmware.git;a=summary

Regards,

Fabio Estevam
