From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Mon, 25 Jun 2012 11:09:54 +0530
Subject: [RFC PATCH v2 1/2] drivers: misc: omap: add a new driver for
 ocp2scp
In-Reply-To: <20120623044445.GA2993@kroah.com>
References: <1340370942-23201-1-git-send-email-kishon@ti.com>
 <1340370942-23201-2-git-send-email-kishon@ti.com>
 <20120623044445.GA2993@kroah.com>
Message-ID: <CAAe_U6+dkiQw-i93pFapt6qKrArzaQoE8X3GjDzUDraziG8B2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Sat, Jun 23, 2012 at 10:14 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Jun 22, 2012 at 06:45:41PM +0530, Kishon Vijay Abraham I wrote:
>> Adds a new driver _ocp2scp_.
>
> That's not what you called this driver in the patch below :(
>
>> This driver takes the responsibility of creating
>> all the devices that is connected to OCP2SCP. In the case of OMAP4, USB2PHY
>> is connected to ocp2scp.
>>
>> This also includes device tree support for ocp2scp driver and
>> the documentation with device tree binding information is updated.
>
> Can't this live where the scp drivers live? ?Actually, where is that at?
> Do we have scp drivers?
AFAIK, there isn't any driver for scp. But we have a driver for ocp
and it is present at arch/arm/mach-omap2/omap_l3_noc.c

Thanks
Kishon
