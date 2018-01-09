From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Tue, 9 Jan 2018 13:45:33 +0100
Subject: [PATCH] drivers: firmware: xilinx: Add ZynqMP firmware driver
In-Reply-To: <1515449227-5096-1-git-send-email-jollys@xilinx.com>
References: <1515449227-5096-1-git-send-email-jollys@xilinx.com>
Message-ID: <CAOFm3uEyFohJysxGCQf1UFP3dN80KeE=YGJHkqwyy0QdijStjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jolly,

On Mon, Jan 8, 2018 at 11:07 PM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> This patch is adding communication layer with firmware.
> Firmware driver provides an interface to firmware APIs.
> Interface APIs can be used by any driver to communicate to
> PMUFW(Platform Management Unit). All requests go through ATF.
> Firmware-debug provides debugfs interface to all APIs.
> Firmware-ggs provides read/write interface to
> global storage registers.
>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>

<snip>

> --- /dev/null
> +++ b/drivers/firmware/xilinx/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier:     GPL-2.0+

Thank you++ for using the SPDX tags: here is my cheerful ack for this:

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
