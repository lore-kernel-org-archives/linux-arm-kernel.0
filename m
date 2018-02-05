From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 15:31:57 +0800
Subject: [PATCH v3 1/3] ARM: dts: imx: Pass empty memory size on board dts
In-Reply-To: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
Message-ID: <20180205073156.GK31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 11:22:12AM -0200, Marco Franchi wrote:
> In preparation for removing 'reg = <0 0>;' from the dtsi SoC files, pass
> 'reg = <0 0 >;' to the dts/dtsi board files that do not pass the memory
> size.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied all, thanks.
