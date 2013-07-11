From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 11 Jul 2013 22:42:57 +0530
Subject: [PATCH v3 0/6] ARM: davinci: da850: add ethernet driver DT support
In-Reply-To: <1371999607-6483-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1371999607-6483-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <CA+V-a8t-sTPAK+D5869X0_ZCdrmK0B+eRaowk9hMYwXMw09NqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Sun, Jun 23, 2013 at 8:30 PM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>
> This patch set enables Ethernet support through device tree model.
> This patch set enables mii interface only and is being tested to boot via
> rootfs. The rmii phy is present on the i2c gpio expander chip (UI board)
> for which yet support needs to be added, once the DT support for the chip
> is enabled, enabling rmii will be subsequnet patch.
>
> Changes for v2:
> 1: Enabled mdio device.
> 2: Fixed clock lookup.
>
> Changes for v3:
> 1: Fixed review comments pointed out by Sekhar.
>
> Lad, Prabhakar (6):
>   ARM: davinci: da8xx: fix clock lookup for mdio device
>   ARM: davinci: da850: add DT node for mdio device
>   ARM: davinci: da850: add OF_DEV_AUXDATA entry for mdio.
>   ARM: davinci: da850: add DT node for eth0.
>   ARM: davinci: da850: add OF_DEV_AUXDATA entry for eth0.
>   ARM: davinci: da850: configure system configuration chip(CFGCHIP3)
>     for emac
>
gentle ping..

Regards,
--Prabhakar Lad
