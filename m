From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Nov 2018 22:39:31 +0800
Subject: [PATCH 1/3] ARM: dts: imx31: Fix memory node duplicaton
In-Reply-To: <1541518847-5640-1-git-send-email-festevam@gmail.com>
References: <1541518847-5640-1-git-send-email-festevam@gmail.com>
Message-ID: <20181116143929.GN5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 01:40:45PM -0200, Fabio Estevam wrote:
> Boards based on imx31 have duplicate memory nodes:
> 
> - One coming from the board dts file: memory@
> 
> - One coming from the imx31.dtsi file.
> 
> Fix the duplication by removing the memory node from the dtsi file
> and by adding 'device_type = "memory";' in the board dts.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied all, thanks.
