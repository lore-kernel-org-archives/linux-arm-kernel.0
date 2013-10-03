From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 3 Oct 2013 11:14:05 -0400
Subject: [PATCH] arm: mvebu: add support for the Armada XP Matrix board
In-Reply-To: <1380810926-32248-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1380810926-32248-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131003151405.GX31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 04:35:26PM +0200, Thomas Petazzoni wrote:
> The Armada XP Matrix board is the mother board of a more complex
> system. The mother board uses an Armada XP MV78460, 4 serial ports, 2
> SATA ports, one Ethernet connection, a PCIe port and a USB port. All
> those devices are enabled in the Device Tree added by this patch.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile             |  1 +
>  arch/arm/boot/dts/armada-xp-matrix.dts | 75 ++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-xp-matrix.dts

Applied to mvebu/dt

thx,

Jason.
