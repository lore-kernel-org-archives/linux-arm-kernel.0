From: shawnguo2@yeah.net (Shawn Guo)
Date: Thu, 9 Jun 2016 10:42:49 +0800
Subject: [PATCH] arm64: dts: Update address-cells and reg properties of
 cpu nodes
In-Reply-To: <1462784775-11684-1-git-send-email-b18965@freescale.com>
References: <1462784775-11684-1-git-send-email-b18965@freescale.com>
Message-ID: <20160609024249.GB15697@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 05:06:15PM +0800, Alison Wang wrote:
> MPIDR_EL1[63:32] value is equal to 0 for the CPUs of the LS1043A and
> LS2080A SoCs. The ARM CPU binding allows #address-cells to be set to 1,
> since MPIDR_EL1[63:32] bits are not used for CPUs identification. Update
> the #address-cells and reg properties accordingly.
> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>

Applied, thanks.
