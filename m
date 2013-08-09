From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 9 Aug 2013 09:21:11 -0400
Subject: [PATCH for v3.12] ARM: mvebu: Relocate PCIe node in Armada 370
 RD board
In-Reply-To: <1375995789-24146-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375995789-24146-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130809132111.GB25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 06:03:09PM -0300, Ezequiel Garcia wrote:
> The pcie-controller node needs to be relocated according the MBus
> DT binding, since it's now a child of the mbus-compatible node.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Applies on mvebu's for-next.
> 
> Jason,
> 
> Please pick this in mvebu/mbus_dt. Somehow this slipped through
> our tests until just now.
> 
> Thanks!
> 
>  arch/arm/boot/dts/armada-370-rd.dts | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Applied to mvebu/mbus_dt

thx,

Jason.
