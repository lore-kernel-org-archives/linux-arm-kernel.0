From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jul 2015 11:14:56 +0800
Subject: [PATCH v2 1/4] ARM: dts: vfxxx: Add io-channel-cells property
 for ADC node
In-Reply-To: <2832d45c2a04c45a583d95a1e351f62c115e8065.1437058481.git.maitysanchayan@gmail.com>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
 <2832d45c2a04c45a583d95a1e351f62c115e8065.1437058481.git.maitysanchayan@gmail.com>
Message-ID: <20150728031456.GA12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 08:43:19PM +0530, Sanchayan Maity wrote:
> This commit adds io-channel-cells property to the ADC node. This
> property is required in order for an IIO consumer driver to work.
> Especially required for Colibri VF50, as the touchscreen driver
> uses ADC channels with the ADC driver based on IIO framework.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>

Applied, thanks.
