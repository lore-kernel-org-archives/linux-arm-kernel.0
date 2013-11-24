From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 22:42:38 -0500
Subject: [PATCH v4 29/31] ARM: mvebu: Add support for NAND controller
 in Armada 370/XP
In-Reply-To: <1383837455-30721-30-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383837455-30721-30-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131124034238.GX29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 12:17:33PM -0300, Ezequiel Garcia wrote:
> The Armada 370 and Armada XP SoC have a NAND controller (aka NFCv2).
> This commit adds support for it in Armada 370 and Armada XP SoC
> common devicetree.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Patches 29 (this one), 30 and 31 applied to mvebu/dt

I'll be working on the core-divider clock issue over the next couple of
days.

thx,

Jason.
