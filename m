From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Nov 2016 11:44:10 -0200
Subject: [PATCH] ARM: dt: imx31: fix AVIC base address
In-Reply-To: <20161117013051.29381-1-vz@mleia.com>
References: <20161117013051.29381-1-vz@mleia.com>
Message-ID: <CAOMZO5CfqBaHaOKEgEFU5a4D8ekJX2Mpoon_3eNAOveKj+=-wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 11:30 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>
> On i.MX31 AVIC interrupt controller base address is at 0x68000000.
>
> The problem was shadowed by the AVIC driver, which takes the correct
> base address from a SoC specific header file.
>
> Fixes: d2a37b3d91f4 ("ARM i.MX31: Add devicetree support")
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Yes, this is what the Reference Manual states, thanks.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
