From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 8 Nov 2018 12:34:03 +0200
Subject: [PATCH 1/3] ARM: dts: imx31: Fix memory node duplicaton
In-Reply-To: <1541518847-5640-1-git-send-email-festevam@gmail.com>
References: <1541518847-5640-1-git-send-email-festevam@gmail.com>
Message-ID: <d73ce8ce-64a0-14e9-74f5-12fde63df1cc@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 11/06/2018 05:40 PM, Fabio Estevam wrote:
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

thank you for the change, I've successfully tested it on my i.MX31 Lite board.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Tested-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
