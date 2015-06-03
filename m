From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 Jun 2015 17:04:11 +0800
Subject: [PATCH] ARM: dts: imx6dl: add imx6dl gpt sepcific compatible
 string
In-Reply-To: <1433317566-4338-1-git-send-email-shawnguo@kernel.org>
References: <1433317566-4338-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20150603090411.GC20344@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 03:46:06PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> The i.MX6DL/S GPT has a different programming model from i.MX6Q one.
> Add the compatible string "fsl,imx6dl-gpt" for it, and leave
> "fsl,imx6q-gpt" there to keep the existing/old kernel happy.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

s/sepcific/specific in patch subject.

Shawn
