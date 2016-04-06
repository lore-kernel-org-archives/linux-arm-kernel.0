From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 06 Apr 2016 14:00:16 +0200
Subject: [PATCH] ARM: dts: ls1021a: add SCFG MSI dts node
In-Reply-To: <1459940527-26437-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1459940527-26437-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <28653783.sxLdysvvje@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 April 2016 19:02:07, Minghuan Lian wrote:
> Add SCFG MSI dts node and add msi-parent property to PCIe dts node
> that points to the corresponding MSI node.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>

Best regards,
Alexander
