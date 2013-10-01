From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Sep 2013 20:50:32 -0400
Subject: [PATCH,FIX] ARM: mvebu: add missing DT Mbus ranges and
 relocate PCIe DT nodes for RN102
In-Reply-To: <87a9iuq7ff.fsf@natisbad.org>
References: <87a9iuq7ff.fsf@natisbad.org>
Message-ID: <20131001005032.GL31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:19:16AM +0200, Arnaud Ebalard wrote:
> 
> When 5e12a613 and 0cd3754a were introduced, Netgear ReadyNAS 102 .dts
> file was queued for inclusion and missed the update to have Mbus (and
> then BootROM) ranges properties declared. It also missed the relocation
> of Armada 370/XP PCIe DT nodes introduced by 14fd8ed0 after de1af8d4.
> This patch fixes that which makes 3.12-rc3 bootable on the NAS.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 35 ++++++++++++++------------
>  1 file changed, 19 insertions(+), 16 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
