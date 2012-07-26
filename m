From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 26 Jul 2012 06:56:32 -0400
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select MXS_DMA
In-Reply-To: <CAOMZO5DUN5d_aN=j8bfj6n3of=r2A-mu+jqNXCR-4HVTA7kS6Q@mail.gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-3-git-send-email-festevam@gmail.com>
 <CAMiH66EA4O0s8hfXkr_SJ56+q7eZ8w0=3C1r_C+m2Os1RxprmA@mail.gmail.com>
 <CAOMZO5BfT+_7x4F96Kvqtq5STXxw2Y9CxbCCAc_UnZ-3wy0qxg@mail.gmail.com>
 <CAMiH66FUxiw0B8iD5rYi=nUX0VYZBzOKifXKfTqd1RmSHhC80g@mail.gmail.com>
 <CAOMZO5DUN5d_aN=j8bfj6n3of=r2A-mu+jqNXCR-4HVTA7kS6Q@mail.gmail.com>
Message-ID: <CAMiH66HCih0=zWqhwAGj+rVTW7-9vNO8y-6tC+p8R7yg=+sojw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 6:53 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jul 25, 2012 at 11:24 PM, Huang Shijie <shijie8@gmail.com> wrote:
>
>> But you have added "depend on MXS_DMA". So If you do not select the
>> mxs-dma, you can not see the
>> gpmi-nand.
>> that's why i think this patch is not needed.
>
> So how CONFIG_MXS_DMA would be selected if not via defconfig?
Use the make menuconfig ARCH=arm:

"device drivers"-->"DMA engine support" -->"mxs dma support"

Huang Shijie
