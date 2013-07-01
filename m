From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Jul 2013 10:59:20 -0300
Subject: [PATCH 1/2] ARM: dts: mx53qsb: Enable VPU support
In-Reply-To: <CAOMZO5Chnn72t12rf6tkrWNSnDreKsh57nagKc5_Vhi0j_mSWw@mail.gmail.com>
References: <1372459759-10488-1-git-send-email-festevam@gmail.com>
 <1372683396.4971.35.camel@pizza.hi.pengutronix.de>
 <CAOMZO5Chnn72t12rf6tkrWNSnDreKsh57nagKc5_Vhi0j_mSWw@mail.gmail.com>
Message-ID: <CAOMZO5DGcrB-mGMODJFY2fXxNKt9dDPc5i5KUMJ_bwbBFQJMxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Jul 1, 2013 at 10:46 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Thanks for your C code, Philipp.
>
> Now I get:
>
> coda 63ff4000.vpu: Initialized CODA7541.
> coda 63ff4000.vpu: Unsupported firmware version: 13.4.41
> coda 63ff4000.vpu: codec registered as /dev/video0
>
> As input file I am using the vpu_fw_imx53.bin from FSL BSP version 11.09.
>
> Where should I get the vpu_fw_imx53.bin file so that I do not get the
> unsupported warning?

Ok, now I used the mx53 firmware from the latest FSL 4.0.0 BSP and I get:

coda 63ff4000.vpu: Initialized CODA7541.
coda 63ff4000.vpu: Unsupported firmware version: 1.4.50
coda 63ff4000.vpu: codec registered as /dev/video0

and it seems that the version warning appears because your patch:
https://linuxtv.org/patch/19020/ is not applied in the tree linux-next
tree I am using.

Thanks,

Fabio Estevam
