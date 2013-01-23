From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 09:14:01 -0500
Subject: [PATCH 3.9] arm: mvebu: add button for OpenBlocks AX3-4
In-Reply-To: <1357576198-24574-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576198-24574-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130123141401.GM1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 05:29:58PM +0100, Thomas Petazzoni wrote:
> The OpenBlocks AX3-4 board has one software-controlled button on the
> front side, labeled "INIT", so we add minimal support for this button
> in the kernel.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied to mvebu/dt

thx,

Jason.
