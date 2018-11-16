From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Nov 2018 13:19:35 +0800
Subject: [PATCH v2 1/2] ARM: dts: imx51: Fix memory node duplicaton
In-Reply-To: <1541452486-26597-1-git-send-email-festevam@gmail.com>
References: <1541452486-26597-1-git-send-email-festevam@gmail.com>
Message-ID: <20181116051933.GK5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 07:14:45PM -0200, Fabio Estevam wrote:
> Boards based on imx51 have duplicate memory nodes:
> 
> - One coming from the board dts file: memory@
> 
> - One coming from the imx51.dtsi file.
> 
> Fix the duplication by removing the memory node from the dtsi file
> and by adding 'device_type = "memory";' in the board dts.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied both, thanks.
