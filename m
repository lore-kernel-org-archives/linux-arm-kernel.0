From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 10:36:37 -0500
Subject: [PATCH 0/2] ARM: mvebu: fix DT def. of PCIe units for mv78230
 and mv78260
In-Reply-To: <cover.1383681717.git.arno@natisbad.org>
References: <cover.1383681717.git.arno@natisbad.org>
Message-ID: <20131123153637.GM29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:45:33PM +0100, Arnaud Ebalard wrote:
> Arnaud Ebalard (2):
>   ARM: mvebu: second PCIe unit of Armada XP mv78230 is only x1 capable
>   ARM: mvebu: fix second and third PCIe units of Armada XP mv78260
> 
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi |  24 +++----
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 109 ++++++++++++++++++++++++-------
>  2 files changed, 97 insertions(+), 36 deletions(-)

Whole series applied to mvebu/dt-fixes with Thomas' Ack and Cc'd to
stable for v3.10.x and up.

thx,

Jason.
