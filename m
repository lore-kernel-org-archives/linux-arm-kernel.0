From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Nov 2018 16:52:54 +0800
Subject: [PATCH 1/2] ARM: dts: imx23: Fix memory node duplicaton
In-Reply-To: <1543234136-6824-1-git-send-email-festevam@gmail.com>
References: <1543234136-6824-1-git-send-email-festevam@gmail.com>
Message-ID: <20181128085252.GO20643@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 10:08:55AM -0200, Fabio Estevam wrote:
> Boards based on imx23 have duplicate memory nodes:
> 
> - One coming from the board dts file: memory@
> 
> - One coming from the imx23.dtsi file.
> 
> Fix the duplication by removing the memory node from the dtsi file
> and by adding 'device_type = "memory";' in the board dts.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
