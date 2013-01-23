From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 08:40:05 -0500
Subject: [PATCH 3.8-rc] arm: mvebu: add LEDs support to defconfig file
In-Reply-To: <1357576034-24193-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576034-24193-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130123134005.GL1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 05:27:14PM +0100, Thomas Petazzoni wrote:
> The OpenBlocks AX3-4 platform has several LEDs, so it sounds wise to
> enable LED support in mvebu_defconfig. We anticipate that more
> platforms using Marvell EBU SoCs will have LEDs in the future.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This is 3.8-rc material.
> ---
>  arch/arm/configs/mvebu_defconfig |    5 +++++
>  1 file changed, 5 insertions(+)

Applied to mvebu/boards

thx,

Jason.
