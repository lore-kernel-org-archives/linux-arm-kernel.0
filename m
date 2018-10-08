From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Oct 2018 15:33:07 +0800
Subject: [PATCH V9 0/3] soc: imx: add scu firmware api support
In-Reply-To: <1538917483-1818-1-git-send-email-aisheng.dong@nxp.com>
References: <1538917483-1818-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181008073304.GP3587@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2018 at 09:04:40PM +0800, Dong Aisheng wrote:
> Unlike the former i.MX Architectures, the new generation i.MX8 SoCs
> (e.g. MX8QXP and MX8QM) contain a system controller which runs on a
> dedicated Cortex-M core to provide power, clock, Pad, and resource
> management. Communication between the host processor running
> an OS and the system controller happens through a SCU protocol.
> This patchset adds the SCU APIs which is implemented based on MU
> and will be used by different system components.
> 
> It mainly consists of below parts:
> 1) SCU IPC
>    Basic IPC mechanism implemention based on mailbox which is used
>    for communication between AP and SCU firmware.
> 2) SCU IPC Service API
> 
> v8->v9:
>  * only scu headfile path update from include/soc/imx to
>    include/linux/firmware/imx
> 
> Dong Aisheng (3):
>   dt-bindings: arm: fsl: add scu binding doc
>   firmware: imx: add SCU firmware driver support
>   firmware: imx: add misc svc support

Applied all, thanks.

I'm waiting for the MAINTAINERS update to send another pull request to
arm-soc folks.

Shawn
