From: david@lechnology.com (David Lechner)
Date: Mon, 19 Feb 2018 12:03:35 -0600
Subject: [PATCH v2 0/2] Add reboot modes for LEGO MINDSTORMS EV3
In-Reply-To: <1515724191-30499-1-git-send-email-david@lechnology.com>
References: <1515724191-30499-1-git-send-email-david@lechnology.com>
Message-ID: <be3b9e55-a425-cf82-39e4-6ee625ece7fd@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 08:29 PM, David Lechner wrote:
> This series adds a new device tree node to declare a special memory
> address that is used by the I2C bootloader on LEGO MINDSTORMS EV3
> to boot into a special firmware update mode and enables the required
> module to use it.
> 
> v2 changes:
> * rebase on linux-davinci/master
> 
> David Lechner (2):
>    ARM: dts: da850-lego-ev3: Add node for reboot modes
>    ARM: davinci_all_defconfig: enable SYSCON_REBOOT_MODE
> 
>   arch/arm/boot/dts/da850-lego-ev3.dts   | 17 +++++++++++++++++
>   arch/arm/configs/davinci_all_defconfig |  1 +
>   2 files changed, 18 insertions(+)
> 

Hi Sekhar,

Any objection to pickup up this series? It is independent of all
of the other changes I have been working on.
