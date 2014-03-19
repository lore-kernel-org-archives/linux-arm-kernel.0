From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 19 Mar 2014 13:31:58 +0100
Subject: [PATCH v4 3/3] ARM: dts: berlin2q: add the Marvell BG2-Q DMP
 device tree
In-Reply-To: <1395153167-21029-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1395153167-21029-1-git-send-email-antoine.tenart@free-electrons.com>
 <1395153167-21029-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53298E3E.5060803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2014 03:32 PM, Antoine T?nart wrote:
> Adds initial support for the Marvell BG2-Q DMP. The board has 2GB of
> memory, an uart activated and what's initially supported by the Marvell
> Armada 1500 pro dtsi.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/Makefile                 |  3 ++-
>   arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 28 ++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/berlin2q-marvell-dmp.dts

Applied to berlin/dt.

Sebastian
