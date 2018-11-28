From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Nov 2018 16:30:06 +0800
Subject: [PATCH] ARM: dts: imx50: Fix memory node duplicaton
In-Reply-To: <1542979519-31747-1-git-send-email-festevam@gmail.com>
References: <1542979519-31747-1-git-send-email-festevam@gmail.com>
Message-ID: <20181128083004.GL20643@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 11:25:19AM -0200, Fabio Estevam wrote:
> imx50-evk has duplicate memory nodes:
> 
> - One coming from the board dts file: memory@
> 
> - One coming from the imx50.dtsi file.
> 
> Fix the duplication by removing the memory node from the dtsi file
> and by adding 'device_type = "memory";' in the board dts.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
