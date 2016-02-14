From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 15:02:39 +0800
Subject: [PATCH 1/1 v3] ARM: dts: imx6dlq-wandboard-revb1.dts: use unique
 model id
In-Reply-To: <1454892908-26975-1-git-send-email-xypron.glpk@gmx.de>
References: <56B7E06B.2060701@gmx.de>
 <1454892908-26975-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <20160214070239.GI6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 01:55:08AM +0100, Heinrich Schuchardt wrote:
> Downstream packages like Debian flash-kernel use
> /proc/device-tree/model
> to determine which dtb file to install.
> 
> Hence each dts in the Linux kernel should provide a unique model
> identifier.
> 
> Commit 8536239e371f ("ARM: dts: Restructure imx6qdl-wandboard.dtsi for new
> rev C1 board.")' created new files imx6dl-wandboard-revb1.dts and
> imx6q-wandboard-revb1.dts but used the same model identifier as in
> imx6dl-wandboard.dts and imx6q-wandboard.dts.
> 
> This patch provides unique model identifiers for revision B1 of
> the Wandboard Dual and Wandbaord Quad.
> 
> The patch leaves imx6dl-wandboard.dts and imx6q-wandboard.dts unchanged
> because it is not foreseeable if the same dts will valid for future
> board revisions or not. Furthermore we should avoid unnecessary
> changes.
> 
> v3:
> 	update imx6dl-wandboard-revb1.dts
> 
> v2:
> 	correct name of referenced Debian package
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied, thanks.
