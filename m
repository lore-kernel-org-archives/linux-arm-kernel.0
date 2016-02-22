From: robh@kernel.org (Rob Herring)
Date: Sun, 21 Feb 2016 20:54:01 -0600
Subject: [PATCH 3/3] clk: mvebu: add AP806 ring clock driver
In-Reply-To: <1455521698-7905-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455521698-7905-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160222025401.GF15973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 08:34:58AM +0100, Thomas Petazzoni wrote:
> This commit adds a new driver to handle the ring clocks found in the
> AP806 HW block, which is the core block of all Armada 7K and 8K
> Marvell 64-bits processors. Those ring clocks are derived from the
> core ring clock handled by the AP806 core clock driver. The ring
> clocks are used by various peripherals inside the AP806.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../clock/mvebu-armada-ap806-ring-clock.txt        | 32 +++++++++++

Combine this with the other patch. Similar comments as the other one.

>  drivers/clk/mvebu/Kconfig                          |  3 +
>  drivers/clk/mvebu/Makefile                         |  1 +
>  drivers/clk/mvebu/ap806-ring.c                     | 65 ++++++++++++++++++++++
>  4 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-ring-clock.txt
>  create mode 100644 drivers/clk/mvebu/ap806-ring.c
