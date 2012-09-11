From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Tue, 11 Sep 2012 14:20:11 +0530
Subject: [PATCH] arm/dts: omap: Add omap-usb2 dt data
In-Reply-To: <504EF4FD.2080001@ti.com>
References: <1347343932-3656-1-git-send-email-kishon@ti.com>
 <504EF4FD.2080001@ti.com>
Message-ID: <CAAe_U6+8MAUAZgLZq8+Yc6SxOCJ0xQ4NFO-R4p2kgiSOXHZL2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 11, 2012 at 1:53 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> Hi Kishon,
>
> On 09/11/2012 08:12 AM, Kishon Vijay Abraham I wrote:
>> Add omap-usb2 data node in omap4 device tree file. Since omap-usb2 is
>> connected to ocp2scp, omap-usb2 dt data is added as a child node
>> of ocp2scp.
>
> Could you add more details about the omap-usb2?
I think information about omap-usb2 driver is added in
 *usb: phy: add a new driver for omap usb2 phy.*.
Do you want the same thing to be added here?
>
> You must update the Documentation binding with that compatible name.
Yes. It's part of *usb: phy: add a new driver for omap usb2 phy.*
> Is it already part of the driver serie? The MUSB driver is referring to
> "ti,musb-omap2430" only.

Will correct the Documentation for MUSB.

Thanks
Kishon
