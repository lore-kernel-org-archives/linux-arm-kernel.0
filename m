From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 Aug 2016 15:03:37 -0300
Subject: 1 of 705 Linux 4.7.0 on freescale imx6 quad udoo board.
In-Reply-To: <CADo9au1MD=H_1Jn+d0j8+O8gRChAtmp1uZ=fgKEpS+z+w94RLA@mail.gmail.com>
References: <CADo9au1MD=H_1Jn+d0j8+O8gRChAtmp1uZ=fgKEpS+z+w94RLA@mail.gmail.com>
Message-ID: <CAOMZO5A4pteSDKt6nscN+maQJ=p+wktzPdaYY_-CmE9DqQjpsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2016 at 2:56 PM, Anshuman Gupta <anshexp@gmail.com> wrote:
> I am trying to boot the udoo (freescale imx6 quad) with vanilla linux
> kernel 4.7.0 with  ubuntu  file system.
>
> I am trying a root over nfs , kernel boots successfully and  `root
> file system mounted
>
> but the shell is not launching it seems it has locked up somewhere ,
> console just get hang.
>
> whether it is a issue with init/file system or kernel.
>
> Any help or point to debug this further will  be highly appreciated.

Is your rootfs spawning the correct serial port? On Udoo it is ttymxc1 (UART2).
