From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Aug 2016 11:13:54 +0200
Subject: [Patch v4 9/9] arm64: Update device tree for Layerscape SoCs
In-Reply-To: <1470780000-16750-1-git-send-email-york.sun@nxp.com>
References: <1470780000-16750-1-git-send-email-york.sun@nxp.com>
Message-ID: <20160812091354.GB333@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 02:59:39PM -0700, York Sun wrote:
> Add DDR memory controller nodes to enable EDAC driver.
> 
> Signed-off-by: York Sun <york.sun@nxp.com>
> 
> ---
> Change log
>   v4: no change
>   v3: no change
>   v2: no change
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  7 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)

This needs an ACK from DT people.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
